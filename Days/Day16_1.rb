valvelist = File.read(File.join(File.dirname(__FILE__),  "../Inputs/Input16.txt"))
@valves = []
@flows = {}
@distance = Hash.new { |distance, key| distance[key] = 10000 }

for valve in valvelist.split(/\n/)
    valve = valve.match /Valve (\w+) .*=(\d*); .* valves? (.*)/
    @valves << valve[1]
    flo = valve[2].to_i
    if flo > 0
        @flows.store(valve[1], flo)
    end
    for v in valve[3].split(', ')
        @distance.store(valve[1]+v, 1)
    end
end

# Floyd-Warshall
for v1,v2,v3 in @valves.product(@valves, @valves)
    @distance.store(v1+v3, [@distance[v1+v3], @distance[v1+v2] + @distance[v2+v3]].min)
end

@cache = {}
def findmax(time, v1='AA', vlvs)
    params = v1+time.to_s+vlvs.join
    unless @cache[params]
        result = []
        for v2 in vlvs
            if @distance.has_key? v1+v2
                if @distance[v1+v2] < time
                    part1 = @flows[v2].nil? ? 0 : @flows[v2]
                    part2 = findmax((time-@distance[v1+v2]-1), v2, vlvs - [v2])
                    result.append(part1 * (time-@distance[v1+v2]-1) + part2)
                end
            end
        end
        result << 0
        findmax = result.max
        @cache.store(params, findmax)
        return findmax
    end
    return @cache[params]
end

p findmax(30, 'AA', @valves)