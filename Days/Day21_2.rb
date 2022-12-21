monkeyyells = File.read(File.join(File.dirname(__FILE__),  "../Inputs/Input21.txt"))
register = {}
unsolved = {}
solved = {}

for monkey in monkeyyells.split(/\n/)
    m, op = monkey.split(': ')
    oplist = op.split(' ')
    unless m == 'humn'
        if oplist.length < 2 then
            register[m] = op.to_i
            solved[m] = op.to_i
        else
            oplist = op.split(' ')
            register[m] = oplist
            unsolved.key(oplist[0]) ? unsolved[oplist[0]].append(m) : unsolved[oplist[0]] = [m]
            unsolved.key(oplist[2]) ? unsolved[oplist[2]].append(m) : unsolved[oplist[2]] = [m]
        end
    end
end

def is_num? string
    true if Float(string) rescue false
end

register["root"].delete_at(1)
debug = false
unless debug
    while solved.size() > 0
        nsolve = {}
        for sk in solved.keys()
            for us in unsolved[sk]
                register[us][register[us].index(sk)] = solved[sk]
                if is_num?(register[us][0]) && is_num?(register[us][2])
                    register[us] = eval(register[us].join())
                    nsolve[us] = register[us]
                end
            end
        end
        solved = nsolve
    end
end


def reg_fill(rgstr, register)
    if rgstr.instance_of?(Array)
        left = rgstr[0]
        right = rgstr[-1]
        if register.keys.include? left
            left = reg_fill(register[left], register)
        end
        if register.keys.include? right
            right = reg_fill(register[right], register)
        end
        return ["(", left, rgstr[1], right, ")"].join
    else
        return rgstr
    end
end

for reg in register.keys
    unless reg == "root"
        register[reg] = reg_fill(register[reg], register)
    end
end

left, right = is_num?(register["root"][0]) ? register["root"] : register["root"].reverse
right = register[right][1..-2]

until right == "humn"
    lb = right.index('(')
    rb = right.rindex(')')
    if lb.nil?
        oper = right.sub("humn", "")
        remain = "humn"
    else
        remain = right[lb+1..rb-1]
        oper = right.sub(right[lb..rb], '')
    end
    num = oper.scan(/\d+/).first
    operand = oper.sub(num, '')
    num = num.to_i
    case operand
    when "+"
        left -= num
    when "-"
        if oper.index('-') > 1
            left = num - left
        else
            left += num
        end
    when "/"
        left *= num
    when "*"
        left /= num
    end
    right = remain
end
p left