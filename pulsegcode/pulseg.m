function pulseg(mode,x)
% PULSEG��MODE,X�������������壬֧������ģʽ
% ��һ��������ģʽ���ӡ�T���͡�C����ѡ��
% �ڶ���������һά����
% ģʽ��T����[��ʼʱ�̣�����ʱ��]
% ģʽ��C����[����ʱ�䣬��ƺ���ߣ�1���ͣ�0��]

if mode ~= 'T' && mode ~= 'C'
    error(' choose from mode T and C!');
end
if isnumeric(x) == 0
    error('must be a numerical array!');
end
if nargin ~= 2
    error('should provide two variables!');
end
if(mod(length(x),2) ~= 0)
    error('input array must have an even number of elements!');
end

if mode == 'T'

%�����ʼʱ���Ƿ���ʱ������˳�����    
for k=2:length(x)/2
    if x(2*k-1) < x(2*k-3)
        error('time order must be ascending!');
    end
end

%�������ĸ������Ƿ��ص�
for k=2:length(x)/2
    if x(2*k-1) <= (x(2*k-3) + x(2*k-2) - 1)
        error('Overlap!');
    end
end

%��������������飬��ʼȫ0����������������ĩβ��5��0
y=zeros(1,x(length(x)) + x(length(x)-1) + 5);

%���������ʱ���ڽ�0��Ϊ1
for k = 1:length(x)/2
    for j = 1:x(2*k)
        y(x(2*k-1) + j) = 1;
    end
end

%���ո�����ʽ���
fid=fopen('data_T.txt','wt');
fprintf(fid,'%d:\n',x(1));
for k=1:length(x)/2-1
    fprintf(fid,'%d:   MW\n',x(2*k));
    fprintf(fid,'%d:\n',x(2*k+1)-x(2*k)-x(2*k-1));
end
fprintf(fid,'%d:   MW\n',x(length(x)));
fprintf(fid,'%d ',y);
fclose(fid);

elseif mode == 'C'
     %�������ĵ�ƺ�����Ƿ���Ч
    for k = 1:length(x)/2
        if x(2*k) ~= 0 && x(2*k) ~= 1
            error('must provided 0 or 1!');
        end
    end
    
    %��������������飬��ʼȫ0����������������ĩβ��5��0
    sum = 0;
    for k = 1:length(x)/2
        sum = sum + x(2*k-1);
    end
    y = zeros(1,sum + 5);
    
    %���ݸ����ĵ�ƺ�����ڹ涨������1
    sumx = 0;
    for k=1:length(x)/2
        for j=1:x(2*k-1)
            y(sumx + j) = x(2*k);
        end
        sumx = sumx + x(2*k-1);
    end
    
    %���ո�����ʽ���
    fid=fopen('data_C.txt','wt');
    for k=1:length(x)/2
      if(x(2*k)==1)
        fprintf(fid,'%d:   MW\n',x(2*k-1));
    else
        fprintf(fid,'%d:\n',x(2*k-1));
      end
    end
   fprintf(fid,'%d ',y);
   fclose(fid); 

end




    
    