#! /bin/awk


#-D[Server:server-one] -XX:PermSize=256m -XX:MaxPermSize=256m -Xms1303m -Xmx1303m -D[Host Controller]=true -Djava.awt.headless=true 
##if
BEGIN { print "\t\t <orderedlist>"}

{
	for ( i = 1; i < NF ; i++ )
	{
	 	if ( $i ~ /XX:PermSize/ )
		{
			printf "\n\t\t\t<listitem>\n\t\t\t\t<para>%s</para>\n\t\t\t</listitem>\n", $i;
		}
		if ( $i ~ /XX:MaxPermSize/ )
		{
		printf "\n\t\t\t<listitem>\n\t\t\t\t<para>%s</para>\n\t\t\t</listitem>\n", $i;
		}
		if( $i ~ /Xms/ )
		{
		printf "\n\t\t\t<listitem>\n\t\t\t\t<para>%s</para>\n\t\t\t</listitem>\n", $i;
		}
		if($i ~ /Xmx/ )
		{
		printf "\n\t\t\t<listitem>\n\t\t\t\t<para>%s</para>\n\t\t\t</listitem>\n", $i;
		}
	
	}

}
END{ print "\t\t </orderedlist>"}
