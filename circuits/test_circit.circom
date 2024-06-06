pragma circom 2.0.0;


template A(N){
   signal  c <== N;
   signal output out <== c;
}

template Multiplier2 () {  

   // Declaration of signals.
   signal input a;  
   component a_val = A(1);  
   signal output c <== a * a_val.out;  
}

component main = Multiplier2();
