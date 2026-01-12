# 0,1,1,2,3,5,8,13,21,34,55
limit = 10
arr = [0, 1] 
for i in 0..limit do
    if i>1 
        arr <<  arr[i-1.to_i] + arr[i-2] 
    end
end
puts arr

arr = [10,9,8,9,7,10,9]
def avg(arr, sum=0, i=0)    
    return sum.to_f/arr.size if i == arr.size
    avg(arr,(sum + arr[i]),i+1);
end
puts avg(arr)

# Average Accumulator alternative
puts "Acumulator averag version"
puts arr.inject { |sum, n|  sum + n }.to_f / arr.size
