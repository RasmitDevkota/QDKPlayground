namespace Quantum.QDK_Playground {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Arrays;

    open Microsoft.Quantum.Diagnostics;

    @EntryPoint()
    operation Main() : Unit {
        let count = 1024;

        using (register = Qubit[4]) {
            mutable q0 = register[0];
            mutable q1 = register[1];
            mutable q2 = register[2];
            mutable q3 = register[3];

            mutable results = [0, 0, 0, 0];

            mutable message = "";

            for (test in 1..count) {
                SetQubitState(Zero, q0);
                SetQubitState(Zero, q1);
                SetQubitState(Zero, q2);
                SetQubitState(Zero, q3);

                set (q0, q1, q2, q3) = Collapse01(q0, q1, q2, q3);
                
                
                let v0 = M(q0);
                let v1 = M(q1);
                let v2 = M(q2);
                let v3 = M(q3);

                let values = [v0, v1, v2, v3];

                for (i in 0..Length(register) - 1) {
                    if (values[i] == Zero) {
                        set results w/= i <- results[i] + 1;
                    }
                }

                DumpMachine("group.txt");
            }

            for (i in 0..Length(register) - 1) {
                set message += $"v{i}: {results[i]}, {count - results[i]}";

                if (i != Length(register) - 1) {
                    set message += "\n";
                }
            }

            Message(message);

            ResetAll(register);
        }
    }

    operation Collapse01(q0: Qubit, q1: Qubit, q2: Qubit, q3: Qubit) : (Qubit, Qubit, Qubit, Qubit) {
        H(q0);
        H(q1);
        H(q2);
        H(q3);

        CNOT(q2, q0);
        CNOT(q3, q0);

        H(q2);
        H(q3);

        CNOT(q0, q1);
        CNOT(q3, q1);

        H(q0);
        H(q1);
        H(q2);
        H(q3);

        /// Or
        // H(q0);
        // H(q1);
        // H(q2);
        // H(q3);

        // CNOT(q0, q2);
        // CNOT(q1, q2);

        // H(q0);
        // H(q1);

        // CNOT(q1, q3);
        // CNOT(q2, q3);

        return (q0, q1, q2, q3);
    }

    operation Collapse23(q0: Qubit, q1: Qubit, q2: Qubit, q3: Qubit) : (Qubit, Qubit, Qubit, Qubit) {
        H(q0);
        H(q1);
        H(q2);
        H(q3);

        CNOT(q0, q2);
        CNOT(q1, q2);

        H(q0);
        H(q1);

        CNOT(q1, q3);
        CNOT(q2, q3);

        H(q0);
        H(q1);
        H(q2);
        H(q3);

        return (q0, q1, q2, q3);
    }

    operation Collapse02(q0: Qubit, q1: Qubit, q2: Qubit, q3: Qubit) : (Qubit, Qubit, Qubit, Qubit) {
        H(q0);
        H(q1);
        H(q2);
        H(q3);

        CNOT(q0, q2);
        CNOT(q1, q2);

        H(q0);
        H(q1);

        CNOT(q1, q3);
        CNOT(q2, q3);

        H(q1);
        H(q2);

        return (q0, q1, q2, q3);
    }

    operation Collapse13(q0: Qubit, q1: Qubit, q2: Qubit, q3: Qubit) : (Qubit, Qubit, Qubit, Qubit) {
        H(q0);
        H(q1);
        H(q2);
        H(q3);

        CNOT(q0, q3);
        CNOT(q1, q3);

        H(q0);
        H(q1);

        CNOT(q0, q2);
        CNOT(q3, q2); 

        H(q0);
        H(q3);

        /// Or
        // H(q0);
        // H(q1);
        // H(q2);
        // H(q3);

        // CNOT(q0, q2);
        // CNOT(q1, q2);

        // H(q0);
        // H(q1);

        // CNOT(q1, q3);
        // CNOT(q2, q3);

        // H(q0);
        // H(q3);

        return (q0, q1, q2, q3);
    }

    operation Collapse0(q0: Qubit, q1: Qubit, q2: Qubit, q3: Qubit) : (Qubit, Qubit, Qubit, Qubit) {
        H(q0);
        H(q1);
        H(q2);
        H(q3);

        CNOT(q0, q2);
        CNOT(q1, q2);

        H(q0);
        H(q1);

        CNOT(q1, q3);
        CNOT(q2, q3);

        H(q1);

        return (q0, q1, q2, q3);
    }

    operation Collapse1(q0: Qubit, q1: Qubit, q2: Qubit, q3: Qubit) : (Qubit, Qubit, Qubit, Qubit) {
        H(q0);
        H(q1);
        H(q2);
        H(q3);

        CNOT(q0, q3);
        CNOT(q1, q3);

        H(q0);
        H(q1);

        CNOT(q0, q2);
        CNOT(q3, q2); 

        H(q0);

        /// Or
        // H(q0);
        // H(q1);
        // H(q2);
        // H(q3);

        // CNOT(q0, q2);
        // CNOT(q1, q2);

        // H(q0);
        // H(q1);

        // CNOT(q1, q3);
        // CNOT(q2, q3);

        // H(q0);

        return (q0, q1, q2, q3);
    }

    operation Collapse012(q0: Qubit, q1: Qubit, q2: Qubit, q3: Qubit) : (Qubit, Qubit, Qubit, Qubit) {
        H(q0);
        H(q1);
        H(q2);
        H(q3);

        CNOT(q0, q2);
        CNOT(q1, q2);

        H(q0);
        H(q1);

        CNOT(q1, q3);
        CNOT(q2, q3);

        H(q2);
        
        return (q0, q1, q2, q3);
    }

    operation Collapse013(q0: Qubit, q1: Qubit, q2: Qubit, q3: Qubit) : (Qubit, Qubit, Qubit, Qubit) {
        H(q0);
        H(q1);
        H(q2);
        H(q3);

        CNOT(q0, q2);
        CNOT(q1, q2);

        H(q0);
        H(q1);

        CNOT(q1, q3);
        CNOT(q2, q3);
        
        H(q3);

        return (q0, q1, q2, q3);
    }

    operation Collapse023(q0: Qubit, q1: Qubit, q2: Qubit, q3: Qubit) : (Qubit, Qubit, Qubit, Qubit) {
        H(q0);
        H(q1);
        H(q2);
        H(q3);

        CNOT(q2, q0);
        CNOT(q3, q0);

        H(q2);
        H(q3);

        CNOT(q0, q1);
        CNOT(q3, q1);

        H(q0);

        return (q0, q1, q2, q3);
    }

    operation Collapse123(q0: Qubit, q1: Qubit, q2: Qubit, q3: Qubit) : (Qubit, Qubit, Qubit, Qubit) {
        H(q0);
        H(q1);
        H(q2);
        H(q3);

        CNOT(q2, q0);
        CNOT(q3, q0);

        H(q2);
        H(q3);

        CNOT(q0, q1);
        CNOT(q3, q1);

        H(q1);

        return (q0, q1, q2, q3);
    }

    operation Duplicate01(q0: Qubit, q1: Qubit, q2: Qubit, q3: Qubit) : (Qubit, Qubit, Qubit, Qubit) {
        H(q0);
        H(q1);

        CNOT(q0, q2);
        CNOT(q1, q2);

        H(q0);
        H(q1);

        CNOT(q1, q3);
        CNOT(q2, q3);
            
        H(q2);
        H(q3);

        return (q0, q1, q2, q3);
    }

    operation Duplicate23(q0: Qubit, q1: Qubit, q2: Qubit, q3: Qubit) : (Qubit, Qubit, Qubit, Qubit) {
        H(q0);
        H(q1);
        H(q2);
        H(q3);

        CNOT(q0, q2);
        CNOT(q1, q2);

        H(q0);
        H(q1);

        CNOT(q1, q3);
        CNOT(q2, q3);

        CNOT(q2, q0);
        CNOT(q3, q0);

        H(q2);
        H(q3);

        CNOT(q0, q1);
        CNOT(q3, q1);

        H(q0);

        return (q0, q1, q2, q3);
    }

    operation DuplicatePairs(q0: Qubit, q1: Qubit, q2: Qubit, q3: Qubit) : (Qubit, Qubit, Qubit, Qubit) {
        H(q2);
        H(q3);

        CNOT(q2, q0);
        CNOT(q2, q1);

        CNOT(q3, q0);
        CNOT(q3, q1);
            
        H(q2);
        H(q3);

        /// Or
        // H(q0);
        
        // CNOT(q0, q1);

        // CNOT(q0, q2);
        
        // CNOT(q0, q3);

        // CNOT(q1, q3);

        // CNOT(q2, q3);

        return (q0, q1, q2, q3);
    }

    operation PerfectQuarter(q0: Qubit, q1: Qubit, q2: Qubit, q3: Qubit) : (Qubit, Qubit, Qubit, Qubit) {
        H(q0);
        
        CNOT(q0, q1);

        CNOT(q1, q2);

        CNOT(q2, q3);

        return (q0, q1, q2, q3);
    }

    operation HalfAndCollapse(q0: Qubit, q1: Qubit, q2: Qubit, q3: Qubit) : (Qubit, Qubit, Qubit, Qubit) {
        H(q0);
        
        CNOT(q0, q1);

        CNOT(q0, q2);

        CNOT(q1, q3);

        CNOT(q2, q3);

        return (q0, q1, q2, q3);
    }

    operation CollapseTest(q0: Qubit, q1: Qubit, q2: Qubit, q3: Qubit) : (Qubit, Qubit, Qubit, Qubit) {
        H(q0);
        
        CNOT(q0, q1);

        CNOT(q0, q2);

        CNOT(q1, q3);

        CNOT(q2, q3);

        H(q0);
        
        H(q1);

        H(q2);

        return (q0, q1, q2, q3);
    }

    // Other Interesting Collapse Results:
    /// 1. Collapse023 + Collapse1 [without the first four Hadamard gates] == Collapse0

    operation TestDifference() : Unit {
        let count = 1024;

        using (register = Qubit[2]) {
            mutable q0 = register[0];
            mutable q1 = register[1];

            mutable same = 0;
            mutable diff = 0;

            for (test in 1..count) {
                SetQubitState(Zero, q0);

                H(q0);
                X(q0);

                CNOT(q0, q1);
                CNOT(q1, q0);

                DumpMachine("groupA.txt");
                
                let firstValue = M(q0);

                SetQubitState(Zero, q0);
                SetQubitState(Zero, q1);

                H(q0);
                X(q1);

                CNOT(q0, q1);
                CNOT(q1, q0);

                DumpMachine("groupB.txt");

                let secondValue = M(q0);

                if (firstValue == secondValue) {
                    set same += 1;
                } else {
                    set diff += 1;
                }
            }

            Message($"{same}, {diff}");

            SetQubitState(Zero, q0);
            SetQubitState(Zero, q1);
        }
    }

    operation Entanglement() : Unit {
        let wantedState = Zero;

        using (register = Qubit[10]) {
            mutable tries = 0;
            mutable failures = 0;

            repeat {
                mutable q0 = register[2 * tries];
                mutable q1 = register[2 * tries + 1];

                let measurements = Entangle(q0, q1);
                let m0 = measurements[0];
                let m1 = measurements[1];

                if (m0 != m1) { // Only useful in a noisy system, i.e. on a real quantum computer, not a simulation
                    Message("Error: m0 and m1 not equal :/");
                    set failures += 1;
                } else {
                    Message($"{m0}, {m1}");
                }

                set tries += 1;
            }
            until (m0 == wantedState and m1 == wantedState);

            Message($"{tries}, {failures}");
        }
    }
    
    operation RunEntangle() : Unit {
        let wantedState = Zero;

        using (register = Qubit[10]) {
            mutable tries = 0;
            mutable failures = 0;

            repeat {
                mutable q0 = register[2 * tries];
                mutable q1 = register[2 * tries + 1];

                let measurements = Entangle(q0, q1);
                let m0 = measurements[0];
                let m1 = measurements[1];

                if (m0 != m1) { // Only useful in a noisy system, i.e. on a real quantum computer, not a simulation
                    Message("Error: m0 and m1 not equal :/");
                    set failures += 1;
                } else {
                    Message($"{m0}, {m1}");
                }

                set tries += 1;
            }
            until (m0 == wantedState and m1 == wantedState);

            Message($"{tries}, {failures}");
        }
    }

    operation Entangle(q0: Qubit, q1: Qubit) : Result[] {
        SetQubitState(Zero, q0);
        SetQubitState(Zero, q1);

        H(q0);
        CNOT(q0, q1);
        let m0 = M(q0);
        let m1 = M(q1);

        SetQubitState(Zero, q0);
        SetQubitState(Zero, q1);

        return [m0, m1];
    }

    operation EntangleWithParticle(q0: Qubit, q1: Qubit) : Result[] {
        SetQubitState(Zero, q0);

        H(q0);

        // Interact q0 with another particle q1

        H(q0);

        // q0 now in an entangled state

        // Do other stuff: https://physics.stackexchange.com/questions/350061/is-it-possible-to-detect-a-particle-without-energy-transfer

        let m0 = M(q0);
        let m1 = M(q1);

        SetQubitState(Zero, q0);
        SetQubitState(Zero, q1);

        return [m0, m1];
    }

    operation PerfectHalf(register: Qubit[]) : Qubit[] {
        let q0 = register[0];
        let q1 = register[1];
        let q2 = register[2];

        H(q0);
        
        CNOT(q0, q1);

        CNOT(q1, q2);

        return [q0, q1, q2];
    }

    operation SetQubitState(desired: Result, q1: Qubit) : Unit {
        if (desired != M(q1)) {
            X(q1);
        }
    }

    operation MessageState(r: Result) : Unit {
        if (r == One) {
            Message("One");
        } else {
            Message("Zero");
        }
    }

    operation MessageData(register: Qubit[]) : Unit {
        mutable message = "";

        for (i in 0..Length(register) - 1) {
            set message += $"v{register[i]}";

            if (i != Length(register) - 1) {
                set message += ", ";
            }
        }
    }
}
