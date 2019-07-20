#! /bin/csh -f
#
## c-shell script to download selected files from rda.ucar.edu using Wget
# NOTE: if you want to run under a different shell, make sure you change
#       the 'set' commands according to your shell's syntax
# after you save the file, don't forget to make it executable
#   i.e. - "chmod 755 <name_of_script>"
#
# Experienced Wget Users: add additional command-line flags here
#   Use the -r (--recursive) option with care
#   Do NOT use the -b (--background) option - simultaneous file downloads
#       can cause your data access to be blocked
set opts = "-N"
#
# Replace "xxxxxx" with your rda.ucar.edu password on the next uncommented line
# IMPORTANT NOTE:  If your password uses a special character that has special
#                  meaning to csh, you should escape it with a backslash
#                  Example:  set passwd = "my\!password"
set passwd = SETPASSWD
set num_chars = `echo "$passwd" |awk '{print length($0)}'`
if ($num_chars == 0) then
echo "You need to set your password before you can continue"
echo "  see the documentation in the script"
exit
endif
@ num = 1
set newpass = ""
while ($num <= $num_chars)
set c = `echo "$passwd" |cut -b{$num}-{$num}`
if ("$c" == "&") then
set c = "%26";
else
if ("$c" == "?") then
set c = "%3F"
else
if ("$c" == "=") then
set c = "%3D"
endif
endif
endif
set newpass = "$newpass$c"
@ num ++
end
set passwd = "$newpass"
#
set cert_opt = ""
# If you get a certificate verification error (version 1.10 or higher),
# uncomment the following line:
#set cert_opt = "--no-check-certificate"
#
if ("$passwd" == "xxxxxx") then
echo "You need to set your password before you can continue"
echo "  see the documentation in the script"
exit
endif
#
# authenticate - NOTE: You should only execute this command ONE TIME.
# Executing this command for every data file you download may cause
# your download privileges to be suspended.
wget $cert_opt -O auth_status.rda.ucar.edu --save-cookies auth.rda.ucar.edu.$$ --post-data="email=MY.EMAIL@asdf.com&passwd=$passwd&action=login" https://rda.ucar.edu/cgi-bin/login
#
# download the file(s)
# NOTE:  if you get 403 Forbidden errors when downloading the data files, check
#        the contents of the file 'auth_status.rda.ucar.edu'
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds608.0/3HRLY/2013/NARRflx_201311_0108.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds608.0/3HRLY/2013/NARRpbl_201311_0109.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds608.0/3HRLY/2013/NARRsfc_201311_0109.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds608.0/3HRLY/2013/NARRclm_201311_0130.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds608.0/3HRLY/2013/NARR3D_201311_0709.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds608.0/3HRLY/2013/NARRflx_201311_0916.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds608.0/3HRLY/2013/NARR3D_201311_1012.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds608.0/3HRLY/2013/NARRpbl_201311_1019.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds608.0/3HRLY/2013/NARRsfc_201311_1019.tar

#wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds608.0/3HRLY/YY1/NARR3D_ YY1MM1_DD103.tar
#wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds608.0/3HRLY/YY1/NARRflx_YY1MM1_DD108.tar
#wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds608.0/3HRLY/YY1/NARRpbl_YY1MM1_DD109.tar
#wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds608.0/3HRLY/YY1/NARRsfc_YY1MM1_DD109.tar
#wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds608.0/3HRLY/YY1/NARRclm_YY1MM1_DD131.tar
#
# clean up
rm auth.rda.ucar.edu.$$ auth_status.rda.ucar.edu
