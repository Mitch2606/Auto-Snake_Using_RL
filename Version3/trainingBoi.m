a = 1;
count = 1;

while((a ~= 0))
    stats = train([Paul, Tony], env);
    
    a = input("Train again [1 Y, 0 N]: ");
    count = count + 1;
    save("Agents.mat", 'Paul', 'Tony', 'env')
end

