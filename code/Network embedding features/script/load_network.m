function A = load_network(filename, ngene)
    M = dlmread(filename);
    A = full(sparse(M(:,1), M(:,2), M(:,3), ngene, ngene));
    if ~isequal(A, A') 
      A = A + A';
    end
    A = A + diag(sum(A, 2) == 0);
  end