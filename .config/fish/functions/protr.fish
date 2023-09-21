function protr --wraps='protonvpn-cli d && protonvpn-cli c -fp udp' --description 'alias protr protonvpn-cli d && protonvpn-cli c -fp udp'
  protonvpn-cli d && protonvpn-cli c -fp udp $argv; 
end
