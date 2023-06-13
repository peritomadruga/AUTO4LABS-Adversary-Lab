Vagrant.configure("2") do |config|

  # WAZUH HIDS MANAGER
  config.vm.define "wazuh" do |wazuh|
    wazuh.vm.box = "generic/ubuntu2204"
    wazuh.vm.hostname = "wazuh"

    wazuh.vm.provider "virtualbox" do |vb|
      vb.memory = "4096"
      vb.cpus = 2
      vb.gui = false
    end

    wazuh.vm.network "private_network", ip: "192.168.56.200"

    wazuh_script = <<-SCRIPT
      # Update and upgrade system packages
      sudo apt-get update
      sudo apt-get upgrade -y

      # Install Wazuh HIDS
      curl -sO https://packages.wazuh.com/4.4/wazuh-install.sh && sudo bash ./wazuh-install.sh -a
      sudo tar -xvf wazuh-install-files.tar wazuh-install-files/wazuh-passwords.txt
      cat wazuh-install-files/wazuh-passwords.txt
      sudo rm wazuh-install-files.tar

      echo "WAZUH INSTALLED AND READY TO MONITORING"
    SCRIPT

    wazuh.vm.provision "shell", inline: wazuh_script, run: "once"
  end

  # WINDOWS server 2019 ENDPOINT
  config.vm.define "windows" do |windows|
    windows.vm.box = "StefanScherer/windows_2019"
    windows.vm.hostname = "Windows-Server-2019"

    windows.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.cpus = 2
      vb.gui = true
      vb.check_guest_additions = false
    end

    windows.vm.network "private_network", ip: "192.168.56.99"

    windows.vm.provision "file", source: "endpoint.ps1", destination: "endpoint.ps1"
    # WinRM configuration (uncomment if required)
    # windows.vm.communicator = "winrm"
    # windows.winrm.username = "vagrant"
    # windows.winrm.password = "vagrant"
    # windows.winrm.host = "192.168.56.99"
    # windows.winrm.port = 5985
    # windows.winrm.timeout = 380
    # windows.winrm.max_tries = 20
    # windows.winrm.retry_delay = 2
  end
end
   
