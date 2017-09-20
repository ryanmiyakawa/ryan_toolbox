function out = package(functionName)

[f, p] = uiputfile(functionName);
dep = matlab.codetools.requiredFilesAndProducts(functionName);

mkdir([p f]);
for k = 1:length(dep)
    copyfile(dep{k}, [p f]);
end


