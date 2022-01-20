# charge la data base de crypto
require_relative '03_crypto_database'

# cree un hash à partir d'un array key et d'un array value de même taille.
# les elements du array value sont dans un premier convertit en float
def hash_generator(key,value)
  value_float = value.collect! {|i| i.to_f}
  hash = Hash[key.zip(value)]
  return hash
end

# détermine le couple (key=>value) qui a la plus grosse valeur parmi le hash
def max_value(hash)
  max = hash.values.max
  hash_max = {}
  hash_max[hash.key(max)]=max
  return hash_max
end 

# détermine le couple (key=>value) qui a la plus petite valeur parmi le hash
def min_value(hash)
  min = hash.values.min
  hash_min = {}
  hash_min[hash.key(min)]=min
  return hash_min
end

# Détermine les devises dont le cours est inférieur à une certaine valeur
def finder_below(hash,max_value)
  hash_below = {}
  hash.each {|key,value|
    if value < max_value
      hash_below[key] = value
    end
  }
  return hash_below
end

# Détermine les devises dont le cours est inférieur à une certaine valeur
def finder_max_below(hash,max_value)
  hash_below = finder_below(hash,max_value)
  hash_max_below = max_value(hash_below)
  return hash_max_below
end

# Menu d'acceuil
def menu
  puts "\nQue souhaitez vous faire? Entrez le chiffre correspondant à l'action souhaitée:"
  puts "\n0. Arrêter le programme"
  puts "1. Trouver la crypto qui a la plus grosse valeur"
  puts "2. Trouver la crypto qui a la plus petite valeur"
  puts "3. Trouver les devises dont le cours est inférieur à une certaine valeur"
  puts "4. Trouver la devise la plus chère parmi celles dont le cours est inférieur à une certaine valeur"
  print "\n> "
  choice = gets.chomp.to_i
  while choice<0 || choice>4
    puts "mauvaise commande. Tapez un nombre entre 0 et 4."
    print "> "
    choice = gets.chomp.to_i
  end
  return choice
end

def sub_menu_capping_value
  puts "Entrer la valeur de cours maximale"
  print "> "
  max_value = gets.chomp.to_f
  return max_value
end

# Orientation de l'action à produire
def generate_action(hash,choice)
  case choice
  when 0
    puts "Bye Bye"
    return
  when 1
    hash_max = max_value(hash)
    hash_max.each {|key,value|
      puts "La plus grosse valeur (#{value}) est detenue par la crypto #{key}"
    }
  when 2
    hash_min = min_value(hash)
    hash_min.each {|key,value|
      puts "La plus petite valeur (#{value}) est detenue par la crypto #{key}"
    }
  when 3
    max_value = sub_menu_capping_value
    hash_below = finder_below(hash,max_value)
    puts "Voici les cryptos ayant une valeur inférieure à #{max_value}:"
    hash_below.each {|key,value|
      puts "#{key} (#{value})"
    }
  when 4
    max_value = sub_menu_capping_value
    hash_max_below = finder_max_below(hash,max_value)

    puts "La crypto #{hash_max_below.keys.join} (#{hash_max_below.values.join}) est la plus chère parmi celles dont le cours est inférieur à #{max_value}"
  else 
    puts "Error: choice not included in the list of possible choices"
  end
end

# méthode perform
def perform(name,value)
  hash_crypto = hash_generator(name,value)
  begin 
    choice = menu
    generate_action(hash_crypto,choice)
    if choice != 0
      puts "Appuyer sur Entrer pour continuer"
      rdm = gets.chomp
    end
  end while choice!=0
end


name = ["Bitcoin", "Ethereum", "XRP", "Bitcoin Cash", "EOS"]
value = ["6558.07", "468.95", "0.487526", "762.84", "8.86"]

perform(crypto_name,crypto_value)


