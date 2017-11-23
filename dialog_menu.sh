#!/bin/bash
#written by Sven Herz	©


test=`apt list dialog 2> /dev/null`
if [[ $test != *"[installiert]"* ]]
	then sudo apt-get install dialog
fi;

	test=`apt list sl 2> /dev/null`
	if [[ $test != *"[installiert]"* ]]
		then 
			passwd=`dialog --passwordbox 'Bitte gib dein -sudo- Passwort ein' 0 0
			3>&1 1>&2 2>&3`;
			echo $passwd | sudo apt-get install --assume-yes sl
	fi;

	sl;

while [ true ]
do

	i=`dialog --menu 'Wähle eine Aktion' 0 0 0\
	1 Anwendungen\
	2 Internet\
	3 Netzwerk\
	4 Benutzerkonten\
	5 'Games;-)'\
	6 Laufwerk\
	0 Exit\
	3>&1 1>&2 2>&3`;

	dialog --clear;

	if [ $i ];
	then

		if [ $i = '0' ];
		then
			clear &&
			exit;

		elif [ $i = '1' ];
		then
			s=`dialog --menu 'Bitte auswählen!' 0 0 0\
			1 'Anwendung installieren'\
			2 'Anwendung deinstallieren'\
			3 'Installierte Anwendungen anzeigen'\
			4 'APT Anwendung anzeigen'\
			5 'Nach APT suchen'\
			6 'Upgrade durchführen'\
			7 'Update durchführen'\
			3>&1 1>&2 2>&3`;

			dialog --clear;

			if [ $s ];
			then

				if [ $s = '1' ];
				then
					a=`dialog --inputbox 'Anwendung zum installieren eingeben! (Durch ; trennen für mehrere.)' 0 70 \
			       		3>&1 1>&2 2>&3`;

					if [ $a ];
			        	then
			        		passwd=`dialog --passwordbox 'Bitte das -sudo- Passwort eingeben' 0 0\
							3>&1 1>&2 2>&3`;
			        		dialog --scrollbar --prgbox Fortschritt: "echo $passwd | sudo apt-get install --assume-yes $a" 40 100;
						read -sn1;

					fi; #$a


				elif [ $s = '2' ];
				then
					a=`dialog --inputbox 'Anwendung zum deinstallieren eingeben! (Durch ; trennen für mehrere.)' 0 70 \
				  	3>&1 1>&2 2>&3`;

					if [ $a ];
			        	then
			        		passwd=`dialog --passwordbox 'Bitte das -sudo- Passwort eingeben' 0 0\
							3>&1 1>&2 2>&3`;
			        		dialog --scrollbar --prgbox Fortschritt: "echo $passwd | sudo -S apt-get remove --purge --assume-yes $a" 35 100;
			       			3>&1 1>&2 2>&3;
							dialog --clear; 
					fi; #$a

				elif [ $s = '3' ]
					then
						reset
						apt list | grep installiert
						echo  -e "\033[33;7mBitte Taste drücken Um Fortzufharen ;-) ;-)\033[0m";
						read -sn1;

				elif [ $s = '4' ]
					then
						reset
						apt list
						echo  -e "\033[33;7mBitte Taste drücken Um Fortzufharen ;-) ;-)\033[0m";
						read -sn1;	
				
				elif [ $s = '5' ]		
					then
						suche=`dialog --inputbox 'Nach welcher APT soll gesucht werden?' 0 0\
						3>&1 1>&2 2>&3`;
						#apt list | grep $suche;
						dialog --scrollbar --prgbox Ergebniss: "apt list | grep $suche
						echo ...................................................
						echo ....................................................
						echo 'Taste drücken um Fortzufahren ;-)'" 25 90 ;

				elif [ $s = '6' ]
					then
						passwd=`dialog --passwordbox 'Bitte das -sudo- Passwort eingeben' 0 0\
						3>&1 1>&2 2>&3`;
						if [ $passwd ]
							then
								#ausgabe=`echo $passwd | sudo -S apt-get upgrade >&2`;
								dialog --scrollbar --prgbox Fortschritt: "echo $passwd | sudo -S apt-get upgrade --assume-yes" 40 90;
						fi;		
				
				elif [ $s = '7' ]
					then
						passwd=`dialog --passwordbox 'Bitte das -sudo- Passwort eingeben' 0 0\
						3>&1 1>&2 2>&3`;
						if [ $passwd ]
							then
								#ausgabe=`echo $passwd | sudo -S apt-get upgrade >&2`;
								dialog --scrollbar --prgbox Fortschritt: "echo $passwd | sudo -S apt-get update --assume-yes" 40 110;
						fi;	

						
						
						
				fi #s1




			fi; #s2
		
		elif [ $i = '2' ]
			then
				s=`dialog --menu 'Bitte auswählen!' 0 0 0\
					1 'Seite im Terminal-Browser öffnen'\
					2 'Seite im grafischem Browser öffnen'\
					3>&1 1>&2 2>&3`;

					dialog --clear;

					if [ $s = '1' ]
						then
							s=`dialog --inputbox 'URL eingeben!!!' 0 0 "http://" \
						       3>&1 1>&2 2>&3`;
						        test=`apt list w3m 2> /dev/null`
								if [[ $test != *"[installiert]"* ]]
									then
									passwd=`dialog --passwordbox 'Bitte das -sudo- Passwort eingeben' 0 0\
									3>&1 1>&2 2>&3`;
									echo $passwd | sudo -S apt-get install w3m >/dev/null
								fi;
						        
						  		if [ $s ];
								then
									w3m $s ;
									read -sn1;
								fi;	clear;
					fi;
					
					if [ $s = '2' ]
						then
							s=`dialog --inputbox 'URL eingeben!!!' 0 0 "http://" \
						       3>&1 1>&2 2>&3`;
						       gnome-open $s >/dev/null;
					fi;


		elif [ $i = '3' ]
			then
				s=`dialog --menu 'Bitte auswählen!' 0 0 0\
	                        1 'ifconfig'\
	                        2 'Ping zu:'\
	                        3>&1 1>&2 2>&3`;
							dialog --clear

			
			if [ $s ]
			then

				if [ $s = '1' ]
				then
					clear;
					dialog --scrollbar --prgbox Fortschritt: "ifconfig" 25 90 ;
					read -sn1;

				elif [ $s = '2' ]
				then
					a=`dialog --inputbox 'IP Adresse eingeben!' 0 0 ''\
					3>&1 1>&2 2>&3`;
					clear;
					ping $a;
					echo "Bitte Taste drücken";
					read -sn1;

				fi;
			fi;

		elif [ $i = '4' ]
		then
			s=`dialog --menu 'Bitte auswählen!' 0 0 0\
                        1 'Benutzer anzeigen'\
                        2 'Benutzer anlegen'\
                        3 'Benutzer löschen'\
                        4 'Benutzerpasswort ändern'\
                        5 'Benutzer UID ändern'\
                        3>&1 1>&2 2>&3`;
			dialog --clear

			if [ $s ]
			then

				if [ $s = '1' ]
					then
						userlist=`less '/etc/passwd' 0 0 `;
						dialog --infobox "$userlist" 0 0;
						read -sn1;


					elif [ $s = '2' ]
						then
							u=`dialog --inputbox 'Benutzername eingeben!' 0 0\
							3>&2 2>&1 1>&3`;
							clear;
							e=`sudo adduser $u --force-badname --gecos GECOS --disabled-password 2>&1`;
							dialog --infobox "$e" 0 0;
							read -sn1;

					elif [ $s = '3' ]
						then
							u=`dialog --inputbox 'Welcher Benutzer soll gelöscht werden?' 0 0\
							3>&1 1>&2 2>&3`;
							dialog --clear;
							
							if [ $u ];
								then
									ergebnis=`sudo deluser $u --remove-home 2>&1`;
									dialog --infobox "$ergebnis" 0 0;
									read -sn1;
									
							fi;

					elif [ 	$s = '4' ]
						then		
							benutzer=`dialog --inputbox 'Das Passwort von welchem Benutzer soll geändert werden?' 0 0\
							3>&2 2>&1 1>&3`;
							if [ $benutzer ]
								then
									passwort=`dialog --passwordbox 'Bitte "sudo" Passwort eingebn' 0 0\
									3>&2 2>&1 1>&3`;
									if [ $passwort ]
										then
											echo $passwort | sudo -S passwd $benutzer >&2;
											read -sn1;
											


											
									fi
							fi;	


					elif [ $s = '5' ]
						then
							benutzer=`dialog --inputbox 'Von welchem Benutzer soll die UID geändert werden?' 0 0\
							3>&2 2>&1 1>&3`;
							dialog --clear;
							uid=`dialog --inputbox "Welche UID soll der Benutzer $benutzer bekommen?" 0 0\
							3>&2 2>&1 1>&3`;
							passwd=`dialog --passwordbox 'Bitte "sudo" Passwort eingeben!' 0 0\
							3>&2 2>&1 1>&3`;
							if [ $benutzer ]
								then 
									ausgabe=`echo $passwd | sudo -S usermod -u $uid $benutzer >&2`;
									if [ $ausgabe ]
										then
											dialog --prgbox 'ausgabe"$ausgabe"' 25 60
											read -sn1; 

									fi;		
							fi;



					

				fi;
			fi;	

		elif [ $i = '5' ]
			then
				s=`dialog --menu 'Bitte wähle eine Aktion!' 0 0 0\
						1 'Ninvaders'\
						2 'Su-Do-Ku'\
						3 'Tetris'\
						4 'Snake'\
						5 'Greed'\
						6 'View the Star Wars Strory'\
						3>&1 1>&2 2>&3`;
						dialog --clear;	

						if [ $s ]
							then
						if [ $s = '1' ]
							then
								test=`apt list ninvaders 2> /dev/null`
								
								if [[ $test != *"[installiert]"* ]]
									then
										passwd=`dialog --passwordbox 'Bitte sudo Passwort eingaben' 0 0\
										3>&2 2>&1 1>&3`;
										echo $passwd | sudo -S apt-get install --assume-yes ninvaders >/dev/null
										
								fi	
								
								ninvaders;
														
						fi;
							

							if [ $s = '2' ]
							then
								test=`apt list sudoku 2> /dev/null`
								
								if [[ $test != *"[installiert]"* ]]
									then
										passwd=`dialog --passwordbox 'Bitte sudo Passwort eingaben' 0 0\
										3>&2 2>&1 1>&3`;
										echo $passwd | sudo -S apt-get install --assume-yes sudoku >/dev/null
										
								fi	
								beep;
								sudoku;
														
							fi;

							if [ $s = '3' ]
							then
								test=`apt list bastet 2> /dev/null`
								
								if [[ $test != *"[installiert]"* ]]
									then
										passwd=`dialog --passwordbox 'Bitte sudo Passwort eingaben' 0 0\
										3>&2 2>&1 1>&3`;
										echo $passwd | sudo -S apt-get install --assume-yes bastet >/dev/null
										
								fi	
								
								xterm -e 'beep -f 330 -l 150 -n -f 1 -l 40 -n -f 494 -l 159 -n -f 1 -l 40 -n -f 660 -l 150 -n -f 1 -l 40 -n -f 590 -l 150 -n -f 660 -l 150 -n -f 494 -l 100 -n -f 494 -l 100 -n -f 523 -l 150 -n -f 1 -l 40 -n -f 440 -l 150 -n -f 1 -l 40 -n -f 494 -l 150 -n -f 1 -l 40 -n -f 392 -l 100 -n -f 392 -l 100 -n -f 440 -l 150 -n -f 370 -l 150 -n -f 1 -l 40 -n -f 392 -l 150 -n -f 1 -l 40 -n -f 330 -l 100 -n -f 330 -l 100 -n -f 370 -l 150 -n -f 1 -l 40 -n -f 294 -l 150 -n -f 1 -l 40 -n -f 330 -l 150 -n -f 247 -l 100 -n -f 247 -l 100 -n -f 261 -l 150 -n -f 1 -l 40 -n -f 311 -l 150 -n -f 1 -l 40 -n -f 330 -l 150 -n -f 1 -l 40 -n -f 247 -l 100 -n -f 247 -l 100 -n -f 262 -l 150 -n -f 1 -l 40 -n -f 370 -l 150 -n -f 1 -l 40 -n -f 330 -l 150 -n -f 1 -l 40 -n -f 494 -l 159 -n -f 1 -l 40 -n -f 660 -l 150 -n -f 1 -l 40 -n -f 590 -l 150 -n -f 660 -l 150 -n -f 494 -l 100 -n -f 494 -l 100 -n -f 523 -l 150 -n -f 1 -l 40 -n -f 440 -l 150 -n -f 1 -l 40 -n -f 494 -l 150 -n -f 1 -l 40 -n -f 392 -l 100 -n -f 392 -l 100 -n -f 440 -l 150 -n -f 370 -l 150 -n -f 1 -l 40 -n -f 392 -l 150 -n -f 1 -l 40 -n -f 330 -l 100 -n -f 330 -l 100 -n -f 370 -l 150 -n -f 1 -l 40 -n -f 294 -l 150 -n -f 1 -l 40 -n -f 330 -l 150 -n -f 247 -l 100 -n -f 247 -l 100 -n -f 261 -l 150 -n -f 1 -l 40 -n -f 311 -l 150 -n -f 1 -l 40 -n -f 330 -l 150 -n -f 1 -l 40 -n -f 247 -l 100 -n -f 247 -l 100 -n -f 262 -l 150 -n -f 1 -l 40 -n -f 370 -l 150 -n -f 1 -l 40 -n -f 330 -l 150 -n -f 1 -l 40' 
								bastet; 

														
							fi;

							if [ $s = '4' ]
							then
								test=`apt list nsnake 2> /dev/null`
								
								if [[ $test != *"[installiert]"* ]]
									then
										passwd=`dialog --passwordbox 'Bitte sudo Passwort eingaben' 0 0\
										3>&2 2>&1 1>&3`;
										echo $passwd | sudo -S apt-get install --assume-yes nsnake >/dev/null
										
								fi	
								
								nsnake;
														
							fi;

							if [ $s = '5' ]
							then
								test=`apt list greed 2> /dev/null`
								
								if [[ $test != *"[installiert]"* ]]
									then
										passwd=`dialog --passwordbox 'Greed ist noch nicht installiert.\
										Gib bitte das -sudo- Passwort ein damit die Installation beginnen kann ;-) ' 0 0\
										3>&2 2>&1 1>&3`;
										echo $passwd | sudo -S apt-get install --assume-yes greed >/dev/null
										
								fi	
								
								greed;
														
							fi;

							if [ $s = '6' ]
								then
									beep -l 60000 -f 1 -D 100 --new -l 350 -f 392 -D 100 --new -l 350 -f 392 -D 100 --new -l 350 -f 392 -D 100 --new -l 250 -f 311.1 -D 100 --new -l 25 -f 466.2 -D 100 --new -l 350 -f 392 -D 100 --new -l 250 -f 311.1 -D 100 --new -l 25 -f 466.2 -D 100 --new -l 700 -f 392 -D 100 --new -l 350 -f 587.32 -D 100 --new -l 350 -f 587.32 -D 100 --new -l 350 -f 587.32 -D 100 --new -l 250 -f 622.26 -D 100 --new -l 25 -f 466.2 -D 100 --new -l 350 -f 369.99 -D 100 --new -l 250 -f 311.1 -D 100 --new -l 25 -f 466.2 -D 100 --new -l 700 -f 392 -D 100 --new -l 350 -f 784 -D 100 --new -l 250 -f 392 -D 100 --new -l 25 -f 392 -D 100 --new -l 350 -f 784 -D 100 --new -l 250 -f 739.98 -D 100 --new -l 25 -f 698.46 -D 100 --new -l 25 -f 659.26 -D 100 --new -l 25 -f 622.26 -D 100 --new -l 50 -f 659.26 -D 400 --new -l 25 -f 415.3 -D 200 --new -l 350 -f 554.36 -D 100 --new -l 250 -f 523.25 -D 100 --new -l 25 -f 493.88 -D 100 --new -l 25 -f 466.16 -D 100 --new -l 25 -f 440 -D 100 --new -l 50 -f 466.16 -D 400 --new -l 25 -f 311.13 -D 200 --new -l 350 -f 369.99 -D 100 --new -l 250 -f 311.13 -D 100 --new -l 25 -f 392 -D 100 --new -l 350 -f 466.16 -D 100 --new -l 250 -f 392 -D 100 --new -l 25 -f 466.16 -D 100 --new -l 700 -f 587.32 -D 100 --new -l 350 -f 784 -D 100 --new -l 250 -f 392 -D 100 --new -l 25 -f 392 -D 100 --new -l 350 -f 784 -D 100 --new -l 250 -f 739.98 -D 100 --new -l 25 -f 698.46 -D 100 --new -l 25 -f 659.26 -D 100 --new -l 25 -f 622.26 -D 100 --new -l 50 -f 659.26 -D 400 --new -l 25 -f 415.3 -D 200 --new -l 350 -f 554.36 -D 100 --new -l 250 -f 523.25 -D 100 --new -l 25 -f 493.88 -D 100 --new -l 25 -f 466.16 -D 100 --new -l 25 -f 440 -D 100 --new -l 50 -f 466.16 -D 400 --new -l 25 -f 311.13 -D 200 --new -l 350 -f 392 -D 100 --new -l 250 -f 311.13 -D 100 --new -l 25 -f 466.16 -D 100 --new -l 300 -f 392.00 -D 150 --new -l 250 -f 311.13 -D 100 --new -l 25 -f 466.16 -D 100 --new -l 700 -f 392 &
									
									dialog --prgbox "telnet towel.blinkenlights.nl" 15 80
									
							fi;		

						fi; #$s

	
		elif [ $i = '6' ]
		then
			s=`dialog --menu 'Bitte wähle eine Aktion!' 0 0 0\
						1 'Laufwerke anzeigen'\
						2 'Laufwerk formatieren'\
						3 'Laufwerk mit Nullen überschreiben'\
						4 'SMART-DATA Check'\
						3>&1 1>&2 2>&3`;
			dialog --clear;	

			if [ $s = '1' ]
				then
					sd=`lsblk -o NAME,SIZE,LABEL,MOUNTPOINT 2>&1`;
					dialog --infobox "$sd" 0 0;
					read -sn1;

				elif [ $s = 2 ];	
					then
						passwd=`dialog --passwordbox 'Sudo Passwort eingeben' 0 0\
						3>&1 1>&2 2>&3`;
						if [ $passwd ]
							then
								laufwerk=`dialog --inputbox 'Welches Laufwerk soll formatiert werden?' 0 0\
								3>&1 1>&2 2>&3`;
								if [ $laufwerk ]
									then
										fomat=`dialog --inputbox 'Welches Format soll verwendet werden?' 0 0\
										3>&1 1>&2 2>&3`;
										if [ $fomat ]
											then
												echo $passwd | sudo -S mount /dev/$laufwerk; 
												dialog --prgbox "echo $passwd | sudo -S mkfs.$fomat /dev/$laufwerk" 15 80;
										fi;
								fi;				
						fi;					

					
				elif [ $s = '3' ]
					then
						passwd=`dialog --passwordbox 'Sudo Passwort eingeben' 0 0\
						3>&1 1>&2 2>&3`;
						if [ $passwd ]
							then
								shred=`dialog --inputbox 'Welches Laufwerk soll mit "shred" überschreiben werden?' 0 0 /dev/\
								3>&1 1>&2 2>&3`;
								if [ $shred ]
									then
										how=`dialog --inputbox '0= Mit Nullen\
										1= Zufallszahlen' 0 40\
										3>&1 1>&2 2>&3`;
										
										if [ $how ]
											then
												#dialog --clear;
												dialog --scrollbar --prgbox Fortschritt: "sudo shred -vzn $how $shred" 20 60;
										fi;		read -sn1;

								fi;	
						fi;		

				
				elif [ $s = '4' ]
					then
						passwd=`dialog --passwordbox 'Sudo Passwort eingeben' 0 0\
						3>&1 1>&2 2>&3`;
						if [ $passwd ]
							then
								smart=`dialog --inputbox 'Welches Laufwerk soll überprüft werden?' 0 0 /dev/\
								3>&1 1>&2 2>&3`;
								if [ $smart ]
									then
										dialog --prgbox SMART-DATA " echo $passwd | sudo -S smartctl -a $smart" 100 120;
								fi
						fi


					

						


								

			fi;


		fi; #i1
	
	else
		clear; exit;
	

	fi; #i2
done


#written by Sven Herz	©