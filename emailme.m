function emailme(msg)

% Define these variables appropriately:
mail = 'ryanmiyakawa@gmail.com'; %Your GMail email address
load pd.mat
% Then this code will set up the preferences properly:
setpref('Internet','E_mail',mail);
setpref('Internet','SMTP_Server','smtp.gmail.com');
setpref('Internet','SMTP_Username',mail);
setpref('Internet','SMTP_Password',pw);
props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true');
props.setProperty('mail.smtp.socketFactory.class', 'javax.net.ssl.SSLSocketFactory');
props.setProperty('mail.smtp.socketFactory.port','465');

% Send the email. Note that the first input is the address you are sending the email to
sendmail('rhmiyakawa@berkeley.edu','MATLAB',msg)