require_relative 'Alphabet'
require_relative 'Student'

students_arr = []
alpha = Alphabet.new('1234')
datas = File.readlines(capture + 'students.txt').map{ |line| line = line.chomp }
count = Array.new(alpha.radix + 1){0}
datas.each do |data|
  d = data.split(' ')
  name = d[0]
  group = d[1]
  student = Student.new(name, group)
  students_arr << student
  count[alpha.to_index(group) + 1] += 1
end
for i in 1..count.length - 1
  count[i] += count[i - 1]
end
res = []
students_arr.each do |s|
  res[count[alpha.to_index(s.group)]] = s
  count[alpha.to_index(s.group)] += 1
end

p res