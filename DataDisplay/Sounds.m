classdef Sounds < handle
    properties
        sadTromboneBits
        sadTromboneFreq
        duhDuhDuuhhBits
        duhDuhDuuhhFreq
    end
    methods
        function me = Sounds()
            [me.duhDuhDuuhhBits, me.duhDuhDuuhhFreq, ~, readinfo] = ...
                wavread('ImagesAndSounds/Duh Duh Duuuuhhhh! (better).wav');
            [me.sadTromboneBits, me.sadTromboneFreq, ~, readinfo] = ...
                wavread('ImagesAndSounds/Sad Trombone.wav');
        end 
        function trombone(me)
            me.play(me.sadTromboneBits, me.sadTromboneFreq);
        end
        function duh(me)
            me.play(me.duhDuhDuuhhBits, me.duhDuhDuuhhFreq);
        end
        function play(me, sample, freq)
            sound(sample,freq);
        end
    end
end