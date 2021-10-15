function good = checkPointer(matrixSize, pointer)
good = 1;
if((pointer(1) > matrixSize(1)) || (pointer(2) > matrixSize(2)))
    good = 0;
end

if(sum(ismember(pointer, 0)) >= 1)
    good = 0;
end

end

