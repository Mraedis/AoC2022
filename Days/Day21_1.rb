monkeyyells = File.read(File.join(File.dirname(__FILE__),  "../Inputs/Input21.txt"))
register = {}
unsolved = {}
solved = {}

for monkey in monkeyyells.split(/\n/)
    m, op = monkey.split(': ')
    oplist = op.split(' ')
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

def is_num? string
    true if Float(string) rescue false
end
  
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
                    if us == "root"
                        p register[us]
                        nsolve = {}
                        break
                    end
                end
            end
        end
        solved = nsolve
    end
end
