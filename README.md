#Whois

This library presents whois information for domains in a variety of TLD's
through a standardized API (see example below).

##Example

    domain.name         #=> "example.com"
    domain.expires_on   #=> 2011-08-13 <Date>
    domain.created_on   #=> 1995-08-14 <Date>
    domain.updated_on   #=> 2004-03-26 <Date>
    domain.database_updated_at #=> Mon Sep 28 23:44:55 UTC 2009 <Time>
    domain.status       #=> ["clientDeleteProhibited", "clientTransferProhibited", "clientUpdateProhibited"]
    domain.name_servers   #=> ["A.IANA-SERVERS.NET", "B.IANA-SERVERS.NET"]
    domain.registrar_name #=> "RESERVED-INTERNET ASSIGNED NUMBERS AUTHORITY"
    domain.whois_server   #=> "whois.iana.org"
    domain.available?   #=> false
    domain.registered?  #=> true
    domain.expired?     #=> false

    domain.raw # Raw whois information

##Code layout

Since pretty much every TLD has a different whois format, the various classes
(which inherit from Domain::Base) in the Domain module (files in domain folder) 
have the following:

- HOST constant: the host name of the whois server
- ATTR_MATCH constant: A regular expression with two groups, that matches each
  key value pair line in the raw whois data. The first group is the key, the
  second group is the value.
- ATTR_NAMES constant: Hash where the key represents a method name of the API
  and value in the text of the key in the raw data (the first group of the
  ATTR_MATCH regexp).
- responds_to <Array of Symbol>: list of the TLDs that this class provides whois data for.
  ( responds_to :biz, :us, :travel )

Methods in *Base* may be overriden in case that the above constants are
insufficient (particular likely for lists of values, such as *status* and
*nameservers*.

##Note on Tests

Tests are against actual whois data and thus are somewhat brittle, especially 
*expires_at* and *updated_at*.

##TODO

Whois information for:
- Registrars
- Nameservers

Additional TLD's
