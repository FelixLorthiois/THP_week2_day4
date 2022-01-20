# charge la data base de handles
require_relative '02_handles_database'

# compte le nombre de handles dans un array
def count_items(array)
  return array.count()
end

# cherche le handle le plus court dans un array
def shortest_item(array)
  shortest = array[0]                       # initialisation du handle le plus court
  shortest_length = shortest.length - 1     # on ne compte pas le @ dans la longueur
  
  array.each do |i|                         # parcourt le tableau et met a jour le handle le plus court
    i_length = i.length - 1                 # on ne compte pas le @ dans la longueur
    if i_length < shortest_length
      shortest = i
      shortest_length = i_length
    end
  end
  return shortest
end

# compte le nombre de handles contenant une taille donnée
def count_size_items(array,size)
  count = 0                                 # initialisation du compteur
  array.each do |i|                         # parcourt le tableau en incrémentant le compteur
    handle_length = i.length - 1            # on ne compte pas le @ dans la longeur
    #puts handle_length
    if handle_length == size
      count += 1
      #puts "count = #{count}"
    end
  end
  return count
end

# compte le nombre de handles commencant par une majuscule
def count_uppercase_start(array)
  count = 0
  array.each do |i|
    handle_start = i[1]
    if handle_start == handle_start.upcase
      count += 1
    end
  end
  return count
end

# Trie les handles de l'array par ordre alphabetique
def sort_alphabet(array)
  return array.sort_by(&:downcase)
end

# Trie les handles de l'array par taille croissante
def sort_length(array)
  return array.sort_by(&:length)
end

# Renvoie la position dans le array du handle recherché
def get_position(array,handle)
  return array.find_index(handle)
end

# Renvoie une repartition des handle par taille, jusqu'a une taille max renseigné par l'utilisateur
def distribution_length(array, max_length)
  distrib = []
  (max_length+1).times do |i|                       # renseigne le tableau de distribution
    distrib[i] = count_size_items(array,i)
  end
  (max_length+1).times do |i|                       # affiche les resultats
    if distrib[i]!=0
      puts "#{distrib[i]} handles ont #{i} caractères"
    end
  end
  rest = count_items(array) - distrib.sum           # calcule le nombre de handle ayant une taille plus grande que le max
  if rest!= 0
    puts "#{rest} handles ont une taille supérieure ou égale à #{max_length}"
  end
end

# Menu d'acceuil
def menu
  puts "\nQue souhaitez vous faire? Entrez le chiffre correspondant à l'action souhaitée:"
  puts "\n0. Arrêter le programme"
  puts "1. Compter le nombre de handles"
  puts "2. Déterminer le handle le plus court de la liste"
  puts "3. Compter le nombre de handles ayant une taille particulière"
  puts "4. Compter le nombre de handles commencant par une majuscule"
  puts "5. Trier les handles par ordre alphabétique"
  puts "6. Trier les handles par taille croissante"
  puts "7. Avoir la position d'un handle particulier"
  puts "8. Obtenir la répartition des handles par taille"
  print "\n> "
  choice = gets.chomp.to_i
  while choice<0 || choice>8
    puts "mauvaise commande. Tapez un nombre entre 0 et 8."
    print "> "
    choice = gets.chomp.to_i
  end
  return choice
end

# sous_menu pour compter le nombre de handles ayant un nombre de caractère particulier
def sub_menu_length
  puts "Entrer la taille recherchée"
  print "> "
  size = gets.chomp.to_i
  return size
end

# sous_menu pour recherche un handle particulier
def sub_menu_handle_finder
  puts "Entrer le handle recherché commencant par @"
  print "> "
  handle = gets.chomp
  return handle
end

# Orientation de l'action à produire
def generate_action(array,choice)
  case choice
  when 0
    puts "Bye Bye"
    return
  when 1
    count = count_items(array)
    puts "Il y a #{count} handles dans la base de données"
  when 2
    shortest = shortest_item(array)
    puts "Le handle le plus court est #{shortest}"
  when 3
    size = sub_menu_length
    count = count_size_items(array,size)
    puts "#{count} handles ont une taille de #{size}"
  when 4
    count = count_uppercase_start(array)
    puts "Il y a #{count} handles commencant par une majuscule"
  when 5
    sort_array = sort_alphabet(array)
    puts "Voici les handles triés par ordre alphabétique:"
    puts sort_array.join(' , ')
  when 6
    sort_array = sort_length(array)
    puts "Voici les handles triés par ordre de taille:"
    puts sort_array.join(' , ') 
  when 7
    handle = sub_menu_handle_finder
    position = get_position(array,handle)
    puts "Le handle #{handle} est située en position #{position} dans la base de données"
  when 8
    distribution_length(array,100)
  else 
    puts "Error: choice not included in the list of possible choices"
  end
end

# méthode perform
def perform(array)
  begin 
    choice = menu
    generate_action(array,choice)
    if choice != 0
      puts "Appuyer sur 'Enter' pour continuer"
      rdm = gets.chomp
    end
  end while choice!=0
end

handles=handles_database
perform(handles)






