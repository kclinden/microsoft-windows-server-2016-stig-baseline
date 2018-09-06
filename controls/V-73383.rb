domain_role = command("wmic computersystem get domainrole | Findstr /v DomainRole").stdout.strip

control "V-73383" do
  title "Separate, NSA-approved (Type 1) cryptography must be used to protect
  the directory data in transit for directory service implementations at a
  classified confidentiality level when replication data traverses a network
  cleared to a lower level than the data."
  desc  "Directory data that is not appropriately encrypted is subject to
  compromise. Commercial-grade encryption does not provide adequate protection
  when the classification level of directory data in transit is higher than the
  level of the network."
   if domain_role == '4' || domain_role == '5'
    impact 0.5
  else
    impact 0.0
  end
  tag "gtitle": "SRG-OS-000396-GPOS-00176"
  tag "gid": "V-73383"
  tag "rid": "SV-88035r1_rule"
  tag "stig_id": "WN16-DC-000140"
  tag "fix_id": "F-79825r1_fix"
  tag "cci": ["CCI-002450"]
  tag "nist": ["SC-13", "Rev_4"]
  tag "documentable": false
  tag "check": "This applies to domain controllers. It is NA for other systems.

  Review the organization network diagram(s) or documentation to determine the
  level of classification for the network(s) over which replication data is
  transmitted.

  Determine the classification level of the Windows domain controller.

  If the classification level of the Windows domain controller is higher than the
  level of the networks, review the organization network diagram(s) and directory
  implementation documentation to determine if NSA-approved encryption is used to
  protect the replication network traffic.

  If the classification level of the Windows domain controller is higher than the
  level of the network traversed and NSA-approved encryption is not used, this is
  a finding."
  tag "fix": "Configure NSA-approved (Type 1) cryptography to protect the
  directory data in transit for directory service implementations at a classified
  confidentiality level that transfer replication data through a network cleared
  to a lower level than the data."
  describe "Separate, NSA-approved (Type 1) cryptography must be used to protect
  the directory data in transit for directory service implementations at a
  classified confidentiality level when replication data traverses a network
  cleared to a lower level than the data." do
    skip "This is a manual check" 
  end if domain_role == '4' || domain_role == '5'
  describe "System is not a domain controller, control not applicable" do
    skip "System is not a domain controller, control not applicable"
  end if domain_role != '4' && domain_role != '5'
end

