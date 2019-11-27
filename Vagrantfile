BOX               = 'alanrickman/vagrant-k8s-box'
BOX_VERSION       = '0.1.0'
PRIVATE_NETWORK   = '192.168.0.'
POD_NETWORK_CIDR  = '172.18.0.0/16'

nodes = [
  { :type => 'master', :box => BOX, :box_version => BOX_VERSION, :private_network => PRIVATE_NETWORK, :ram => 2048, :cpu => 2 },
  { :type => 'worker', :count => 2, :box => BOX, :box_version => BOX_VERSION, :private_network => PRIVATE_NETWORK, :ram => 1024, :cpu => 2 },
]

Vagrant.configure(2) do |config|

  nodes.each do |node|

    if "#{node[:type]}" == "master" then
      config.vm.define "#{node[:type]}" do |node_config|
        node_config.vm.box = node[:box]
        node_config.vm.box_version = node[:box_version]
        node_config.vm.host_name = "#{node[:type]}"
        node_config.vm.network :private_network, ip: "#{node[:private_network]}" + "10"
        node_config.vm.provider "virtualbox" do |v|
          v.customize ["modifyvm", :id, "--memory", node[:ram]]
          v.customize ["modifyvm", :id, "--cpus", node[:cpu]]
        end

        # Run master configuration script to create k8s cluster
        node_config.vm.provision "shell", path: "./scripts/configure_k8s_master.bash", args: [ "#{POD_NETWORK_CIDR}", "#{node[:private_network]}" + "10" ]
      end
    end

    if "#{node[:type]}" == "worker" then
      (0..node[:count]-1).each do |i|
        config.vm.define "#{node[:type]}" + "#{i}" do |node_config|
          node_config.vm.box = node[:box]
          node_config.vm.box_version = node[:box_version]
          node_config.vm.host_name = "#{node[:type]}" + "#{i}"
          node_config.vm.network :private_network, ip: "#{node[:private_network]}#{i + 20}"
          node_config.vm.provider "virtualbox" do |v|
            v.customize ["modifyvm", :id, "--memory", node[:ram]]
            v.customize ["modifyvm", :id, "--cpus", node[:cpu]]
          end

          # Run worker configuration script to join k8s cluster
          node_config.vm.provision "shell", path: "./scripts/configure_k8s_worker.bash", args: "#{node[:private_network]}#{i + 20}"
        end
      end
    end

  end

end