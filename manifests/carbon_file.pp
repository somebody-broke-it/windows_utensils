# == Class: windows_utensils
#
# This module allow you to manage Add a Domain user to localgroup
#
# === Parameters
#
#  Can be found on read me
#
# === Examples
#
#  windows_utensils::addusertogroup{'puppet':
#    username = "DOMAIN\User",
#    group    = "LocalGroup",
#  }
# === Authors
#
# Michael Lucas (mike@lucasnet.org)
#
# === Copyright
#
# Copyright 2015 Michael Lucas, unless otherwise noted.
#
class windows_utensils::carbon_file {

  $utensilsdll   = "C:\\windows\\carbon.dll"
  
  file{"${utensilsdll}":
    source => "puppet:///modules/windows_utensils/carbon.dll",
    source_permissions => ignore,
  }
}