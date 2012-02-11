if isempty(timerfind) == 0
    stop(timerfind)
    delete(timerfind)
end
clear all
clear java
clear classes
clc
clear all
clear java
clear classes
tf = timerfind;
if isempty(tf) == 0
    tf{:}
end

jp = javaclasspath;
if isempty(jp)
    jp{:}
end
JavaTest