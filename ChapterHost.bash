#! /bin/bash
#servidores existentes y configuracion jvm

#obtener la ruta del jboss-modules.jar
rutajboss=$(find / -name jboss-modules.jar)
rutajboss=$(echo $rutajboss |awk ' BEGIN { FS ="/" } { for( i=1 ; i < NF ;i++) printf "%s/", $i }{ printf "\n" }')

#echo whereis $JBOSS_HOME
#ruta de jboss_home
touch /tmp/jboss-info/ChapterHost.xml

ChapHost=/tmp/jboss-info/ChapterHost.xml
#numero de servidores
numeroservidores=0
#inicio header xml
echo  -e "<?xml version='1.0' encoding='utf-8' ?>\n" > $ChapHost
echo  -e '<!DOCTYPE chapter PUBLIC "-//OASIS//DTD DocBook XML V4.5//EN" "http://www.oasis-open.org/docbook/xml/4.5/echo  -edocbookx.dtd" [\n' >> $ChapHost
echo  -e '<!ENTITY % BOOK_ENTITIES SYSTEM "JBOSS_INFO.ent">\n'>> $ChapHost
echo  -e '%BOOK_ENTITIES;\n'>> $ChapHost
echo  -e ']>\n'>> $ChapHost
#fin header XML

#inicio Chapter
echo -e "<chapter id = \"Hosts\">\n" >> $ChapHost
echo -e "\t<title>Informacion-del-host</title>\n" >>$ChapHost
awk -f host.awk  $rutajboss/domain/configuration/host.xml >> $ChapHost


#fin capitulo
echo -e "</chapter>\n" >> $ChapHost

##publican

#cp /tmp/ChapterHost.xml  /home/administrador/jbbbb/JBOSS_INFO/en-US/
