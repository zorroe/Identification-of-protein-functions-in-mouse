network_files={'1.txt','2.txt','3.txt','4.txt','5.txt','6.txt','7.txt'};
ngene = 20648;
ndim=100;
svd_approx=true;
x = mashup(network_files, ngene, ndim, svd_approx);
x_T = transpose(x);
csvwrite('14µã48·Ödim100.csv',x_T);