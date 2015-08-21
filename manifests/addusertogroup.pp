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
define windows_utensils::addusertogroup(
  $username    = '',
  $group       = '',
  )
{
  if(empty($username)){
    fail('Username is mandatory')
  }
  if(empty($group)){
    fail('Group is mandatory')
  }
  exec{"Add User to LocalGroup - $group":
    command  => "net.exe localgroup $group $username /add",
    timeout  => 30,
  }

  Exec["Add User to LocalGroup - $group"]
}