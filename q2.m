clear;
cr = 16;
data = gen(cr);
data = transpose(data);
temp = bsxfun(@minus, data, mean(data));
dnorm = transpose(data);
im_create(dnorm, data, cr);
scatter_plot(dnorm, data);

function im_create(dnorm, data, cr)
    cov_mat = cov(dnorm);
    [eVal,~] = eig(cov_mat);
    eVal = fliplr(eVal);
    eVal = eVal(:,1:35);
    recon = eVal'*data;
    recon =pinv(eVal') * recon;
    z = size(data(length(data),:));
    for i = 1:length(data)
         Im = reshape(recon(:,i),[cr, cr, 3]);
         %figure, imshow(uint8(Im));
         if i == 2
         break;
         end
    end
end

function data = gen(cr)
    all_files = 'dataset/*.jpg';
    images = dir(all_files);
    data = [];
    for i = 1:length(images)
        Im = double(imread(fullfile('dataset',images(i).name)));
        J = imresize(Im, [cr cr]);
        data(i,:) = J(:);
    end
end

function scatter_plot(dnorm, data)
        
    cov_mat = cov(dnorm);
    [eVal,~] = eig(cov_mat);
    third_best = eVal(:,1:3);
    second_best = eVal(:,1:2);
    best = eVal(:,1);
    one_d = best'*data;
    two_d = second_best'*data;
    three_d = third_best'*data;
    figure(1);
    scatterplot(one_d);
%     figure(3);
%     scatter(two_d(1,:),two_d(2,:));
%     figure(4);
%     scatter3(three_d(1,:),three_d(2,:),three_d(3,:));
end