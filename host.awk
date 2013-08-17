#! /bin/awk
#para /bin/bash awk -f host.awk  ruta_jboss/domain/configuration/host.xml
BEGIN  { 
		FS = "\""
		varjvms = "false"
		varcomentario ="false"
	   }



{ 
	
	if ( $0 ~ /<!--/) 
	{
		varcomentario = "true";
	}
	else if ( $0 ~/-->/)
	{
		varcomentario = "false" ;
	}
	else if ( varcomentario == "false" )
	{
		if ( $0 ~ /<host/)	
		{
		  print "\t\t<section id =\"HOST\">"

		}
		else if ( $0~ /<\/host>/)
		{
		  print "\t\t</section>"
		}
   		if ( $1 ~ /host name/) 
	 	{
			printf "\t\t<title>Nombre del host : %-10s</title>\n", $2;
		}
		else if( $1 ~ /interface name/)
		{
			printf "\t\t\tNombre de la interfaz: %-10s\n", $2;
		}
		else if ( $1 ~ /inet-address value/ )
		{
			printf"\t\t\t<para>\tConfiguracion IP: %-10s</para>\n" , $2 ;
		}
		#Área configuración máquina virtual
		else if ( $1 ~ /<jvms>/ )
		{
			varjvms = "true" ;
		
			print "\t\t\t<section id =\"JVM-conf\"><title> Configuración JVM</title>" ;
			print "\t\t\t\t<orderedlist>"
		}
		else if ($1 ~ /<\/jvms>/ )
		{
			varjvms = "false" ;
			print"\t\t\t\t</orderedlist>"
			print "\t\t\t</section>"
		}
		else if ( $1 ~ /<servers>/) 
		{
			printf "\t <section id = \"Servidores\" >\n"
   			printf "\t\t<title>Servidores</title>\n\n";
			print "\t\t\t<orderedlist>"
		}
		else if ( $1 ~ /<\/servers>/) 
		{
			print "\t\t\t</orderedlist>"
			printf "\t </section>"

		}		
		else if ( $1 ~ /<server name/) 
		{
			printf "\t\t\t<listitem><para>Nombre: %-10s\t\t\t grupo:%-10s</para></listitem>\n", $2, $4;
		}


	#información de máquinas virtuales
		if (varjvms == "true")
		{	
			if (  $1 ~ /jvm name/)
			{
				#print"\t\tJVM configuracion" ;
				printf "\t\t\t<listitem><para> Nombre: %-10s</para></listitem>\n",  $2 ;
			}
			else if( $1 ~ /heap size/)
			{
				printf "\t\t\t<listitem><para>Heap:\n\t\t\t\tsize: %-10s</para></listitem>\n",  $2 ;
				printf "\t\t\t\t<listitem><para>Max size: %-10s</para></listitem>\n",  $4 ;
			}
			else if ( $1 ~ /permgen size/)
			{	
				printf "\t\t\t<listitem><para>Pergem:\n\t\t\t\tsize: %-10s</para></listitem>\n",  $2 ;
				printf "\t\t\t\t<listitem><para>Max size: %-10s</para></listitem>\n",  $4 ;
			}
			else if ( $1 ~ /option value/)
			{
				printf"\t\t\t<listitem><para>Opciones:\n\t\t\t\t%-10s</para></listitem>\n", $2;
			}
			#fin de información de máquinas virtuales
			#area de servidores
			
		}	
	
	} 

}

