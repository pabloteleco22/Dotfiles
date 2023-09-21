function protde --wraps='protonvpn-cli d && exit' --description 'alias protde protonvpn-cli d && exit'
  protonvpn-cli d && exit $argv; 
end
