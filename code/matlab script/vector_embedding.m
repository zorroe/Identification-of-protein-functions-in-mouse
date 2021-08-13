function [w, x, P, fval] = vector_embedding(Q, ndim, maxiter)
    [nnode ncontext] = size(Q);%求矩阵的行数存到nnode中，矩阵的列数存到ncontext中
    nparam = (nnode + ncontext) * ndim;%q的行数列数相加乘以输出尺寸
    disp('nnode',nnode);
    disp('ncontext',ncontext);
    %% Optimize   优化
    opts = struct('factr', 1e4, 'pgtol', 0, 'm', 5, 'printEvery', 50, 'maxIts', maxiter);

    while true
      %% Initialize vectors   初始化向量
      fprintf('Initializing vectors ... ');tic
      wx = rand(ndim, nnode + ncontext) / 10 - .05;%生成ndim*（nnode + ncontext）的均匀随机数组除以10再减0。05
      fprintf('done. '); toc

      opts.x0 = wx(:);%在结构体opts中加入x0项让其等于 wx(:)(将wx矩阵生成一列第二列摞在第一列下面第三列摞在第二列下面)
      [xopt, fval, info] = lbfgsb(@optim_fn, -inf(nparam,1), inf(nparam,1), opts);
      if info.iterations > 10
        break
      end
      fprintf('Premature termination (took %d iter to converge); trying again.\n', info.iterations);
      info
    end
    wx = reshape(xopt, ndim, nnode + ncontext);

    fprintf('Done.\n');
    
    %% Summarize output
    w = wx(:,1:ncontext);
    disp('size(w):',size(w));
    x = wx(:,ncontext+1:end);
    disp('size(x):',size(x))
    P = P_fn(w,x);
    fval = obj_fn(P);
    
    function [fval, grad] = optim_fn(wx)
        wx = reshape(wx, ndim, nnode + ncontext);

        P = P_fn(wx(:,1:ncontext), wx(:,ncontext+1:end));

        fval = obj_fn(P);

        wgrad = wx(:,ncontext+1:end) * (P-Q);
        xgrad = wx(:,1:ncontext) * (P-Q)';
        grad = [wgrad, xgrad];

        grad = grad(:);
    end

    function P = P_fn(w, x)
        P = exp(x' * w);
        P = bsxfun(@rdivide, P, sum(P));
    end

    function res = obj_fn(P)
        v = zeros(ncontext,1);
        for j = 1:ncontext
            v(j) = kldiv(Q(:,j),P(:,j));
        end
        res = sum(v);
    end
   
    function res = kldiv(p,q)
        filt = p > 0;
        res = sum(p(filt) .* log(p(filt) ./ q(filt)));
    end
end
