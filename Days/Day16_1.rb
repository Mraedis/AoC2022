valvelist = File.read(File.join(File.dirname(__FILE__),  "../Inputs/Input16.txt"))
@flows = Hash.new { |flow, key| flow[key] = 0 }
@distance = Hash.new { |distance, key| distance[key] = 10000 }
@valves = []

for valve in valvelist.split(/\n/)
    valve = valve.match /Valve (\w+) .*=(\d*); .* valves? (.*)/
    @valves << valve[1]
    flo = valve[2].to_i
    if flo > 0
        @flows.store(valve[1], flo)
    end
    for v2 in valve[3].split(', ')
        @distance.store(valve[1]+v2, 1)
    end
end

# Floyd-Warshall
for v1,v2,v3 in @valves.product(@valves, @valves)
    @distance.store(v2+v3, [@distance[v2+v3], @distance[v2+v1] + @distance[v1+v3]].min)
end

@cache = {}
def findmax(time, v1, vlvs, elephant)
    params = v1+time.to_s+vlvs.join+elephant.to_s
    unless @cache[params]
        result = [0]
        for v2 in vlvs
            edge = v1+v2
            if @distance[edge] < time
                result.append(@flows[v2] * (time-@distance[edge]-1) + findmax((time-@distance[edge]-1), v2, vlvs - [v2], elephant))
            end
            if elephant
                result.append(findmax(26, 'AA', vlvs, false))
            end
        end
        findmax = result.max
        @cache.store(params, findmax)
        return findmax
    end
    return @cache[params]
end

p findmax(30, 'AA', @flows.keys, false)
p findmax(26, 'AA', @flows.keys, true)