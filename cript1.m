clc; close; clear;
m1 = 'четверной квадрат';
c=encrypt(m1);
disp(char(c));
m2 = decrypt(c);
disp(char(m2));




function g = ctoiconv(s,n)
    g = zeros(1,n);
    for i = 1:n
        if s(1,i) == 32
            g(1,i) = 34;
        end
        if s(1,i) == 1104
            g(1,i) = 7;
        end
        if s(1,i) == 44
            g(1,i) = 35;
        end
        if s(1,i) == 46
            g(1,i) = 36;
        end
        if s(1,i) > 1077 && s(1,i) < 1104
            g(1,i) = s(1,i)-1070;
        end
        if s(1,i) > 1071 && s(1,i) < 1078
            g(1,i) = s(1,i)-1071;
        end
    end
end

function g = chdig(s1,s2,n)
    g = zeros(1,n);
    for i = 1:2:n-1
        g(1,i)= (s1(i+1)-1)*6 + s2(i);
    end
    for i = 2:2:n
        g(1,i)= (s1(i-1)-1)*6 + s2(i);
    end
end

function g = trans(s1,s2,n,s)
    g = zeros(1,n);
    for i = 1:2:n-1
        g(1,i)= s1(1,s(1,i));
    end
    for i = 2:2:n
        g(1,i)= s2(1,s(1,i));
    end
end

function g = encrypt(p)
    n = length(p);
    if mod(n,2) ~= 0
        s = [p ' '];
        n = n+1;
    else
        s=p;
    end
    s=ctoiconv(s,n);
    sx = mod(s-1,6)+1;
    sy = ceil(s/6);
    m1 = [1076 1072 1088 1090 32 1074 1077 1081 1097 1104 1082 1086 1100 1103 1085 1095 1080 1089 1079 1073 1091 1075 1094 1092 1083 1078 1084 1087 1093 1096 1098 1099 1101 1102 44 46];
    m2 = [1074 32 1095 1072 1097 1093 1102 1075 1078 1080 1083 1073 1099 1094 1090 1088 1091 1089 44 1076 1085 1086 1092 1100 1096 1081 1101 1082 1079 1077 1084 1087 1103 46 1104 1098];
    
    g=chdig(sy,sx,n);
    g=trans(m1,m2,n,g);
end

function g = decrypt(s)
    n = length(s);
    s = ctoiconv(s,n);
    m1 = [2 20 6 22 1 7 10 26 19 17 8 11 25 27 15 12 28 3 18 4 21 24 29 23 16 30 9 31 32 13 33 34 14 5 35 36];
    m2 = [4 12 1 8 20 30 35 9 29 10 26 28 11 31 21 22 32 16 18 15 17 23 6 14 3 25 5 36 13 24 27 7 33 2 19 34];
    T = [1072 1073 1074 1075 1076 1077 1104 1078 1079 1080 1081 1082 1083 1084 1085 1086 1087 1088 1089 1090 1091 1092 1093 1094 1095 1096 1097 1098 1099 1100 1101 1102 1103 32 44 46];

    g=trans(m1,m2,n,s);
    
    gx = mod(g-1,6)+1;
    gy = ceil(g/6);
    
    g = chdig(gy,gx,n);
    
    for i = 1:n
        g(1,i)= T(1,g(1,i));
    end
end

