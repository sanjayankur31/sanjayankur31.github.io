Accessing UCL VPN using OpenConnect on Linux systems
####################################################
:date: 2024-11-25 14:49:25
:modified: 2024-11-25 14:49:25
:author: ankur
:category: Tech
:tags: UCL, VPN, AnyConnect, OpenConnect, Linux, Fedora
:slug: accessing-ucl-vpn-using-openconnect-on-linux-systems
:summary: A quick note on accessing UCL VPN using OpenConnect on Linux systems.


I needed to use the `UCL VPN <https://www.ucl.ac.uk/isd/services/get-connected/ucl-virtual-private-network-vpn>`__ again, on my Fedora/Linux machine.
Linux isn't really supported by the university infrastructure, but there are `instructions that others have come up with <https://blogs.ucl.ac.uk/dh/2015/09/18/tutorial-ucl-vpn-linux/>`__ and they had worked for me the last time I'd needed VPN access.
Unfortunately, that was a few years ago, and things have changed a little since then.
Notably, UCL has introduced two factor authentication (2FA).

I had to look around a little but I did manage to get it to work again using NetworkManager.
I thought I'd write it up quickly so everyone that needs it, including future me, have a quick reference to look at.

This is on Fedora 41 with the following OpenConnect packages:

.. code:: bash

    $ rpm -qa \*openconnect\*
    openconnect-9.12-6.fc41.x86_64
    NetworkManager-openconnect-1.2.10-6.fc41.x86_64
    NetworkManager-openconnect-gnome-1.2.10-6.fc41.x86_64


In NetworkManager one needs to create a new VPN connection with the following settings:


.. figure:: {static}/images/20241125-openconnect-nm.png
    :width: 80%
    :align: center
    :alt: Screenshot of settings in Network Manager for setting up a VPN connection to UCL VPN using Open Connect (settings are listed below)
    :target: {static}/images/neuroml-logo.png
    :class: text-center img-responsive pagination-centered

Here are the settings in a list too:

- VPN Protocol: Cisco AnyConnect or OpenConnect
- Gateway: vpn.ucl.ac.uk
- User Agent: AnyConnect
- CA Certificate: <None>
- Proxy: <leave blank>
- Allow security scanner trojan (CSD): Yes (checked)
- Trojan (CSD) wrapper script: :code:`/usr/libexec/openconnect/csd-post.sh`
- Reported OS: Windows 10 (I didn't try another)
- Machine certificate: <None>
- Machine private key: <will be greyed out>
- User certification: <None>
- User private key: <will be greyed out>
- Use FSID for key passphrase: No (unchecked)
- Prevent user from manually accepting invalid credentials: No (unchecked)
- Token mode: TOTP - manually entered


This is similar to what had worked before.
What changed:

- It didn't work without setting the User Agent to "AnyConnect"
- I set the token mode to "TOTP - manually entered"

This opens up a web login page where one can enter their credentials.
