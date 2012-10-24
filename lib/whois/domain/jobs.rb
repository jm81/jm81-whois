require 'whois/domain/verisign_grs'

class Whois::Domain::Jobs < Whois::Domain::VerisignGrs
  HOST = "whois.verisign-grs.com"
  ATTR_MATCH = /^   ([^:]+):\W*(.*)$/
  responds_to :jobs, :tv

  ATTR_NAMES = {
    :status => 'Domain Status',
    :registrar_name => 'Sponsoring Registrar'
  }
end
