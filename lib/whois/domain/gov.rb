# All I know how to get so far is domain name and status.
# There is a web interface at http://www.dotgov.gov/whois.aspx
# with more detail.
class Whois::Domain::Gov < Whois::Domain::Base
  HOST = "whois.nic.gov"
  ATTR_MATCH = /^([^:]+):\s(.*)\r$/
  responds_to :gov

  ATTR_NAMES = {
  }
  
  def available?
    @raw !~ /Domain Name:/
  end
  
  def register_url
    "http://www.dotgov.gov/help_how.aspx"
  end
  
  def name_servers
    []
  end
  
  def ns
    []
  end
end