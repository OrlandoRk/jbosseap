#! /bin/bash
#servidores existentes y configuracion jvm

#obtener la ruta del jboss-modules.jar
rutajboss=$(find / -name jboss-modules.jar)
#echo whereis $JBOSS_HOME
#ruta de jboss_home
touch /tmp/jboss-info/ChapterServidores.xml

ChapServidores=/tmp/jboss-info/ChapterServidores.xml
#numero de servidores
numeroservidores=0
#inicio header xml
echo  -e "<?xml version='1.0' encoding='utf-8' ?>\n" > $ChapServidores
echo  -e '<!DOCTYPE chapter PUBLIC "-//OASIS//DTD DocBook XML V4.5//EN" "http://www.oasis-open.org/docbook/xml/4.5/echo  -edocbookx.dtd" [\n' >> $ChapServidores
echo  -e '<!ENTITY % BOOK_ENTITIES SYSTEM "JBOSS_INFO.ent">\n'>> $ChapServidores
echo  -e '%BOOK_ENTITIES;\n'>> $ChapServidores
echo  -e ']>\n'>> $ChapServidores
#fin header XML

rutajboss=$(echo $rutajboss |awk ' BEGIN { FS ="/" } { for( i=1 ; i < NF ;i++) printf "%s/", $i }{ printf "\n" }')
echo -e "<chapter id = \"Servidores-Jboss\">\n" >> $ChapServidores
echo -e "<title>Servidores</title> <para> rutajboss\n" >> $ChapServidores
echo $rutajboss >> $ChapServidores
rutaserveraux=$rutajboss"domain/servers/"
echo -e "\t\t " $rutaserveraux >> $ChapServidores

finrutaserver=$"/log/server.log" >> $ChapServidores
echo -e "</para>\n" >> $ChapServidores


ls $rutaserveraux -1   > /tmp/servidores.info


	while read line
		do
		 numeroservidores=$[$numeroservidores+1]
	  	 echo -e "\t<section id = \"Servidores-Jboss-Existentes"$numeroservidores"\">\n" >> $ChapServidores
		  echo -e "\t\t<title>servidor :"$line"</title>\n" >> $ChapServidores
		  #echo -e "\t\t "$line"\n"		
		  #echo -e "\t\t\t<para>\n" >> $ChapServidores
 		  rutaserver=$rutaserveraux$line$finrutaserver
		  #echo -e $rutaserver #<< ruta de informacion del servidor
		  awk  -f infoserver.awk $rutaserver >> $ChapServidores
	 	  #echo -e "\t\t\t<\para>\n" >> $ChapServidores
  		  echo -e "\t</section>\n" >> $ChapServidores
	done < /tmp/servidores.info
 


echo -e "</chapter>\n" >> $ChapServidores

##publican

#cp /tmp/ChapterServidores.xml  /home/administrador/jbbbb/JBOSS_INFO/en-US/
