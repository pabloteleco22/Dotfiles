function protre --wraps='protonvpn-cli d && protonvpn-cli c -fp udp && exit' --description 'alias protre protonvpn-cli d && protonvpn-cli c -fp udp && exit'
  protonvpn-cli d && protonvpn-cli c -fp udp && exit $argv; 
end
