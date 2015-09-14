# == Class: windows_utensils
#
# This module enables/disables IPv6 Teredo tunneling protocol and stop the IP Helper service if running.
# NOTE:  This module DOES NOT Re-enable Teredo or IPv6 tunnels if they are already disabled.
#
# === Parameters
#
#  Can be found on read me
#
# === Examples
#
#  windows_utensils::network_teredo{'Disable_Teredo':
#    ensure  => disabled,
#  }
# === Authors
#
# Michael Lucas (mike@lucasnet.org)
#
# === Copyright
#
# Copyright 2015 Michael Lucas, unless otherwise noted.
#
define windows_utensils::network_teredo (
  $ensure,
)
{
  require windows_utensils::checkver

  $check_teredo_state = "C:\\Windows\\System32\\cmd.exe /C C:\\Windows\\System32\\netsh.exe interface teredo show state | find /I \"disabled\""

  case $ensure {
    'present','enabled': { info('IPv6 Teredo will remain enabled') }
    'absent','disabled': {

      exec { 'Disable IPv6 6to4':
        command     => "C:\\Windows\\System32\\netsh.exe interface ipv6 6to4 set state state=disabled undoonstop=disabled",
        timeout     => 300,
        unless      => $check_teredo_state,
      }
      ->
      exec { 'Disable IPv6 isatap':
        command     => "C:\\Windows\\System32\\netsh.exe interface ipv6 isatap set state state=disabled",
        timeout     => 300,
        unless      => $check_teredo_state,
      }
      ->
      exec { 'Disable IPv6 Teredo':
        command     => "C:\\Windows\\System32\\netsh.exe interface teredo set state disabled",
        timeout     => 300,
        unless      => $check_teredo_state,
      }
      ->
      service { 'iphlpsvc':
        ensure => stopped,
      }
    }
    default: { fail('--> ensure metaparameter is mandatory') }
  }
}