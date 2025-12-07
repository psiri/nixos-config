{ config, pkgs, ... }:

let
  # Define VM XML file with nix interpolations for store paths
  #   then use pkgs.writeText to create the XML file in the Nix store.
  vmXml = pkgs.writeText "win11.xml" ''
    <domain type="kvm">
      <name>win11</name>
      <uuid>2cf84820-7e46-4e59-9ec0-ab6515aace54</uuid>
      <metadata>
        <libosinfo:libosinfo xmlns:libosinfo="http://libosinfo.org/xmlns/libvirt/domain/1.0">
          <libosinfo:os id="http://microsoft.com/win/11"/>
        </libosinfo:libosinfo>
      </metadata>
      <memory unit="KiB">16777216</memory>
      <currentMemory unit="KiB">16777216</currentMemory>
      <vcpu placement="static">4</vcpu>
      <os firmware="efi">
        <type arch="x86_64" machine="pc-q35-9.2">hvm</type>
        <firmware>
          <feature enabled="no" name="enrolled-keys"/>
          <feature enabled="yes" name="secure-boot"/>
        </firmware>
        <loader readonly="yes" secure="yes" type="pflash" format="raw">${ovmfPackage.fd}/FV/OVMF_CODE.fd</loader>
        <nvram template="${ovmfPackage.fd}/FV/OVMF_VARS.fd" templateFormat="raw" format="raw">/var/lib/libvirt/qemu/nvram/win11_VARS.fd</nvram>
        <boot dev="hd"/>
      </os>
      <features>
        <acpi/>
        <apic/>
        <hyperv mode="custom">
          <relaxed state="on"/>
          <vapic state="on"/>
          <spinlocks state="on" retries="8191"/>
          <vpindex state="on"/>
          <runtime state="on"/>
          <synic state="on"/>
          <stimer state="on"/>
          <frequencies state="on"/>
          <tlbflush state="on"/>
          <ipi state="on"/>
          <avic state="on"/>
        </hyperv>
        <vmport state="off"/>
        <smm state="on"/>
      </features>
      <cpu mode="host-passthrough" check="none" migratable="on"/>
      <clock offset="localtime">
        <timer name="rtc" tickpolicy="catchup"/>
        <timer name="pit" tickpolicy="delay"/>
        <timer name="hpet" present="no"/>
        <timer name="hypervclock" present="yes"/>
      </clock>
      <on_poweroff>destroy</on_poweroff>
      <on_reboot>restart</on_reboot>
      <on_crash>destroy</on_crash>
      <pm>
        <suspend-to-mem enabled="no"/>
        <suspend-to-disk enabled="no"/>
      </pm>
      <devices>
        <emulator>${pkgs.qemu_kvm}/bin/qemu-system-x86_64</emulator>
        <disk type="file" device="disk">
          <driver name="qemu" type="qcow2"/>
          <source file="/home/psiri/Documents/vms/vm-win11.qcow2"/>
          <target dev="vda" bus="virtio"/>
          <address type="pci" domain="0x0000" bus="0x04" slot="0x00" function="0x0"/>
        </disk>
        <interface type="network">
          <mac address="52:54:00:b2:ff:a5"/>
          <source network="wired"/> <model type="virtio"/>
          <address type="pci" domain="0x0000" bus="0x01" slot="0x00" function="0x0"/>
        </interface>
        
        <graphics type="spice">
          <listen type="none"/>
          <image compression="off"/>
          <gl enable="yes" rendernode="/dev/dri/by-path/pci-0000:c1:00.0-render"/>
        </graphics>
        <video>
          <model type="virtio" heads="1" primary="yes">
            <acceleration accel3d="yes"/>
          </model>
          <address type="pci" domain="0x0000" bus="0x00" slot="0x01" function="0x0"/>
        </video>
      </devices>
    </domain>
  '';
in
{

  # Run 'virsh define' on every activation, keeping the XML in sync with the current Nix store paths.
  systemd.services.define-vms = {
    description = "Define libvirt domains from Nix store";
    after = [ "libvirtd.service" ];
    requires = [ "libvirtd.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      # Define the VM. If it exists, it updates the config.
      ExecStart = "${pkgs.libvirt}/bin/virsh define ${vmXml}";
    };
  };
}