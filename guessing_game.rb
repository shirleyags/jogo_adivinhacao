def welcome 
  puts 'Bem-vindo ao jogo da adivinhação'
  puts 'Qual é o seu nome?'
  name = gets.chomp
  puts "O seu jogo vai começar,#{name}!"
end

def draw_secret_number (last_number)
  puts "Aguarde enquanto escolho o número secreto..."
  sleep (4)
  puts "Prontinho, escolhi! Vamos ver se você consegue adivinhar! kkkkk"
  drawing_number = rand(1..last_number)
  drawing_number
end

def message_choose_number (try, take_a_guess, my_choices)
  last_attempts = "O(s) seu(s) último(s) chute(s) foi/foram #{my_choices}"
  if try == 1
    puts "Digite um número entre 1 e #{@last_number}:"
    take_a_guess = gets.to_i
  elsif try > 1 && try <= 4
    puts "****** #{last_attempts} *****"
    puts "Digite outro número entre 1 e #{@last_number}"
    take_a_guess = gets.to_i
  else
    puts "****** #{last_attempts} *****"
    puts "Atenção essa é sua última chance...pense bem e digite um número:"
    take_a_guess = gets.to_i
  end
end

def check_number_success_or_error(secret_number, take_a_guess, total_score)
  if secret_number == take_a_guess
    puts "Você acertou! Parabéns!"
    puts "Total de pontos: #{total_score.to_f}"
    return true
  else
      if secret_number > take_a_guess
        puts "O número secreto é maior que o digitado"
        return false
      else
        puts "O número secreto é menor que o digitado"
        return false
      end
  end
end

def choose_level_message
    puts "Escolha o nível do jogo 1 - 2 - 3 - 4 - 5"
    level_input = gets.to_i
end

def choose_level
  case choose_level_message
  when 1
    @last_number = 20
    draw_secret_number (@last_number)
  when 2
    @last_number = 40
    draw_secret_number (@last_number)
  when 3
    @last_number = 60
    draw_secret_number (@last_number)
  when 4
    @last_number = 80
    draw_secret_number (@last_number)
  when 5
    @last_number = 100
    draw_secret_number (@last_number)
  else
      puts "Escolha um nível válido, por favor"
      choose_level
  end
end

def loop_of_attempts
  chances_of_guess = 5
  secret_number = choose_level
  my_choices = []
  starting_points = 1000
  sum_attempts = 0

  my_choices.each do |meu_chute|
    soma_meus_chute+=meu_chute
  end
  
  for try in 1..chances_of_guess
    take_a_guess = message_choose_number(try, take_a_guess, my_choices)
    my_choices.push(take_a_guess)
  
    pontos_a_perder = (sum_attempts-secret_number).abs/2 
    total_score = starting_points-pontos_a_perder
    
    if check_number_success_or_error(secret_number, take_a_guess, total_score)
      break
    end

    if try == chances_of_guess
      puts"Que pena não foi dessa vez, você excedeu o número de tentativas.\nO número correto é: #{secret_number}!"
    end
  end
end

def start_game
  welcome
  loop_of_attempts
  restart_game = true
  while restart_game == true
    puts "Gostaria de jogar novamente? Digite 1 (Sim) e 2 (Não)"
    play_again = gets.to_i
    if play_again == 1
      loop_of_attempts
      restart_game = true
    else
      puts "Até a próxima!"
      restart_game = false
    end
  end
end

start_game
