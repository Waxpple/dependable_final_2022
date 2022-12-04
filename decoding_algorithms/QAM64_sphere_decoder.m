function out = QAM64_sphere_decoder(z,R)
        lut = [ -7+ 1i*-7,-7+ 1i*-5,-7+ 1i*-1,-7+ 1i*-3,-7+ 1i*7,-7+ 1i*5,-7+ 1i*1,-7+ 1i*3, ...
            -5+ 1i*-7,-5+ 1i*-5,-5+ 1i*-1,-5+ 1i*-3,-5+ 1i*7,-5+ 1i*5,-5+ 1i*1,-5+ 1i*3, ...
            -1+ 1i*-7,-1+ 1i*-5,-1+ 1i*-1,-1+ 1i*-3,-1+ 1i*7,-1+ 1i*5,-1+ 1i*1,-1+ 1i*3, ...
            -3+ 1i*-7,-3+ 1i*-5,-3+ 1i*-1,-3+ 1i*-3,-3+ 1i*7,-3+ 1i*5,-3+ 1i*1,-3+ 1i*3, ...
            7+ 1i*-7,7+ 1i*-5,7+ 1i*-1,7+ 1i*-3,7+ 1i*7,7+ 1i*5,7+ 1i*1,7+ 1i*3, ...
            5+ 1i*-7,5+ 1i*-5,5+ 1i*-1,5+ 1i*-3,5+ 1i*7,5+ 1i*5,5+ 1i*1,5+ 1i*3, ...
            1+ 1i*-7,1+ 1i*-5,1+ 1i*-1,1+ 1i*-3,1+ 1i*7,1+ 1i*5,1+ 1i*1,1+ 1i*3, ...
            3+ 1i*-7,3+ 1i*-5,3+ 1i*-1,3+ 1i*-3,3+ 1i*7,3+ 1i*5,3+ 1i*1,3+ 1i*3, ...
            ]';

        %算第一層
        acc_cost = abs(z(end)*ones(64,1) -  (1/sqrt(28)) * R(end,end)*lut).^2;
        [acc_cost,index] = mink(acc_cost,16);
        try_index = index;
        %find a greedy solution
        for ndim= 3:-1:2
            try_index = [kron(try_index,ones(64,1)),kron(ones(16,1),(1:64)')];
            temp = kron(acc_cost,ones(64,1));
            temp = temp + (abs(z(ndim) - (1/sqrt(28))*flip(R(ndim,ndim:end))*(lut(try_index).')).^2)';
            [acc_cost,index] = mink(temp,16);
            try_index = try_index(index,:);
        end
        ndim = 1;
        try_index = [kron(try_index,ones(64,1)),kron(ones(16,1),(1:64)')];
        temp = kron(acc_cost,ones(64,1));
        temp = temp + (abs(z(ndim) - (1/sqrt(28))*flip(R(ndim,ndim:end))*(lut(try_index).')).^2)';
        [acc_cost,index] = mink(temp,1);
        sol = try_index(index,:);
        greedy = acc_cost;
        %disp(sol);

        %算第一層
        acc_cost = abs(z(end)*ones(64,1) -  (1/sqrt(28)) * R(end,end)*lut).^2;
        [acc_cost,index] = mink(acc_cost,64);
        acc_cost = acc_cost(acc_cost<=greedy);
        index = index(acc_cost<=greedy);
        try_index = index;
        for ndim= 3:-1:2
            dim_of_try_index = size(try_index);
            try_index = [kron(try_index,ones(64,1)),kron(ones((dim_of_try_index(1)),1),(1:64)')];
            temp = kron(acc_cost,ones(64,1));
            temp = temp + (abs(z(ndim) - (1/sqrt(28))*flip(R(ndim,ndim:end))*(lut(try_index).')).^2)';
            [acc_cost,index] = mink(temp,length(temp));
            acc_cost = acc_cost(acc_cost<=greedy);
            index = index(acc_cost<=greedy);
            try_index = try_index(index,:);
        end
        ndim = 1;
        dim_of_try_index = size(try_index);
        try_index = [kron(try_index,ones(64,1)),kron(ones((dim_of_try_index(1)),1),(1:64)')];
        temp = kron(acc_cost,ones(64,1));
        temp1 = (abs(z(ndim) - (1/sqrt(28))*flip(R(ndim,ndim:end))*(lut(try_index).')).^2)';
        temp = temp+temp1;
        [acc_cost,index] = mink(temp,1);
        try_index = try_index(index,:);
        out = flip(lut(try_index));

end