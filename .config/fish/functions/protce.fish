function protce --wraps='protonvpn-cli c -fp udp && exit' --description 'alias protce protonvpn-cli c -fp udp && exit'
  protonvpn-cli c -fp udp && exit $argv; 
end
