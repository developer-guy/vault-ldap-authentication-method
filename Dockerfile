FROM osixia/openldap:1.4.0
ENV LDAP_ORGANISATION="Developerguy Org" \
    LDAP_DOMAIN="developerguy.org"
COPY bootstrap.ldif /container/service/slapd/assets/config/bootstrap/ldif/50-bootstrap.ldif
