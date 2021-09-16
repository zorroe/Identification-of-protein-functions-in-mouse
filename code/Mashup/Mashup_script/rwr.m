function Q = rwr(A, restart_prob)
  n = size(A, 1);%矩阵的行数
  A = A - diag(diag(A));%减去A的对角线元素
  A = A + diag(sum(A) == 0);
  P = bsxfun(@rdivide, A, sum(A));%将矩阵A的每一列左除sum（A）
  Q = (eye(n) - (1 - restart_prob) * P) \ (restart_prob * eye(n));%eye(n)生成n维的单位矩阵
end
%?求出A的行数，将A减去其对角线元素再赋值给A，将A加上（每行求和后若值为0则该值变为1若不为0该值变为）的对角元素然后赋值给A，将A的每列左除
%每列的和相当于归一化然后赋值给P，用单位矩阵减去0。5*P之后除0。5*单位矩阵结果赋值给Q并返回。