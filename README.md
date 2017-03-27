# docker-svn
Docker container with SVN &amp; LDAP support

# How to run
To run this container

    docker run -d -v data:/svn -v config:/config -p 80:80 aviationcode/subversion:latest

# How to create a new repository

    docker exec -it my_container /bin/bash

    $ svnadmin create /svn/your_new_repo

# Directories

`data` is used to store your SVN repository

`config` contains optional configuration for apache. For example you could add all your ldap permissions here


`config/website.conf

    <Location /svn/website>
        DAV svn
        SVNPath /svn/website
        AuthType Basic
        AuthBasicProvider ldap
        AuthName "svn repository"
        AuthLDAPURL "ldap://ldap/ou=user,dc=acme?uid?sub?(objectClass=Person)"
        AuthLDAPBindAuthoritative on
        AuthLDAPSearchAsUser on
        AuthLDAPCompareAsUser on
        <RequireAll>
            Require valid-user
            <RequireAny>
                Require ldap-group cn=developers,ou=group,dc=acme
            </RequireAny>
        </RequireAll>
    </Location>
