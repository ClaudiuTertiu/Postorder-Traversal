	 	 

		README - POSTORDER TRAVERSAL IN ASSEMBLY
	##########################################################################################

	Am parcurs recursiv arborele prin intermediul a doua apeluri,
unul pe fiul stang si celalalt pe fiul drept si am adaugat 
totul intr-un vector cu tot cu semne, apoi am retinut dimensiunea
vectorului creat. Apoi pentru a calcula am transformat fiecare numar
prin functia atoi implementata care parcurge string-urile caracter cu caracter
si verifica daca un numar este negativ retinandu-i semnul '-'.
	
	In caz afirmativ se face complementul lui 2 prin negare
si incrementare. Apoi la parcurgerea vectorului il iau de la coada
spre inceput cu offset de 4 si fac push in stiva de fiecare numar
pana cand intalnesc un operator dupa care fac 2x pop ( in cazul meu a fost
nevoie sa fac un pop in plus pentru a retrage ecx-ul de pe stiva pe care
l-am pastrat pentru a-l folosi si in alte operatii). Rezultatul
operatiei ii fac push pe stiva pana cand ajunge la ultima operatie
astfel ca ecx este 0 => a fost parcurs tot vectorul si returnez rezultatul
final.
	
	Pentru inmultiri si impartiri am folosit imul si idiv, iar pentru vector
am alocat mai multa memorie pentru a fi sigur ca nu o depaseste. 

