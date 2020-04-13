% name=Ram Gopal Srikar StudentID:40106010


% Do not change the function name. You have to write your code here
% you have to submit this function
function segmentedImage = KMeans(featureImageIn, numberofClusters, clusterCentersIn)

% Get the dimensions of the input feature image
[M, N, noF] = size(featureImageIn);
% some initialization
% if no clusterCentersIn or it is empty, randomize the clusterCentersIn
% and run kmeans several times and keep the best one
if (nargin == 3) && (~isempty(clusterCentersIn))
    NofRadomization = 1;
else
    NofRadomization = 5;    % Should be greater than one
end


segmentedImage = zeros(M, N); %initialize. This will be the output

BestDfit = 1e10;  % Just a big number!
new_segmentedImage=zeros(M,N);
% run KMeans NofRadomization times
for KMeanNo = 1 : NofRadomization

    % randomize if clusterCentersIn was empty
    if NofRadomization>1
        clusterCentersIn = rand(numberofClusters, noF); %randomize initialization
    end
    old=zeros(size(clusterCentersIn));
    
    test=0;
    % find clusters
    while(test<150)
      if(old==numberofClusters)
        break;
      end
     dist2=0;
     dist1=0;
     test=test+1;
    count=zeros(1,numberofClusters);
    sum=zeros(size(clusterCentersIn));
    
    for i=1:M
         for j=1:N
             dist=zeros(1,numberofClusters);
             for k=1:numberofClusters
                 for m=1:noF
                     dist(k)=dist(k)+(featureImageIn(i,j,m)-clusterCentersIn(k,m)).^2;
                 end
                 dist(k)=sqrt(dist(k));
             end
             
             low=find(dist==min(min(dist)));
             segmentedImage(i,j)=min(low);
             
             for m=1:numberofClusters
                if(segmentedImage(i,j)==m)
                    for k=1:noF
                     sum(m,k)=sum(m,k)+featureImageIn(i,j,k);
                     dist1=dist1+((featureImageIn(i,j,k)-clusterCentersIn(m,k)).^2);
                    end
                    dist2=dist2+sqrt(dist1);
                    count(m)=count(m)+1;
                   
                end
             end
             
             
         end
    end
    old=clusterCentersIn;
    for i=1:numberofClusters
        for j=1:noF
            if(count(i)==0)
                clusterCentersIn(i,j)=0;
            else 
            clusterCentersIn(i,j)=sum(i,j)/count(i);
            end
        end
    end
    
    if(dist2<BestDfit)
        new_segmentedImage=segmentedImage;
        BestDfit=dist2;
        
    end
  
    end
end

segmentedImage=new_segmentedImage;





