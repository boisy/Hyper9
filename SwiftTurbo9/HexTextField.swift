import SwiftUI

struct LabeledHex8TextField: View {
    var label = "??"
    @Binding var number: UInt8
    var labelWidth = 22.0
    public var update: (() -> Void) = {}

    var body: some View {
        HStack {
            Text(label)
                .frame(width: labelWidth)
                .multilineTextAlignment(.trailing)
            TextField("", text: Binding<String>(
                get: {
                    // Display the number as a hex string with leading "$"
                    String(format: "$%02X", number)
                },
                set: { newValue in
                    // Remove the "$" prefix and trim whitespace
                    var input = newValue.uppercased().trimmingCharacters(in: .whitespacesAndNewlines)
                    if input.hasPrefix("$") {
                        input.removeFirst()
                    }

                    #if false
                    // Determine if input is hexadecimal or decimal
                    if input.rangeOfCharacter(from: CharacterSet.letters) != nil {
                        // Attempt to parse as hexadecimal
                        if let hexNumber = UInt8(input, radix: 16) {
                            number = hexNumber
                        }
                    } else {
                        // Attempt to parse as decimal
                        if let decNumber = UInt8(input, radix: 10) {
                            number = decNumber
                        }
                    }
                    #else
                    // Attempt to parse as hexadecimal
                    if let hexNumber = UInt8(input, radix: 16) {
                        number = hexNumber
                        update()
                    }
                    #endif
                }
            ))
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .frame(width: 44)
        }
    }
}

struct LabeledHex16TextField: View {
    var label = "??"
    @Binding var number: UInt16
    var labelWidth = 22.0
    public var update: (() -> Void) = {}

    var body: some View {
        HStack {
            Text(label)
                .frame(width: labelWidth)
                .multilineTextAlignment(.trailing)
            Hex16TextField(number: $number)
        }
    }
}

struct Hex16TextField: View {
    @Binding var number: UInt16
    public var update: (() -> Void) = {}

    var body: some View {
        HStack {
            TextField("", text: Binding<String>(
                get: {
                    // Display the number as a hex string with leading "$"
                    String(format: "$%04X", number)
                },
                set: { newValue in
                    // Remove the "$" prefix and trim whitespace
                    var input = newValue.uppercased().trimmingCharacters(in: .whitespacesAndNewlines)
                    if input.hasPrefix("$") {
                        input.removeFirst()
                    }
                    
#if false
                    // Determine if input is hexadecimal or decimal
                    if input.rangeOfCharacter(from: CharacterSet.letters) != nil {
                        // Attempt to parse as hexadecimal
                        if let hexNumber = UInt16(input, radix: 16) {
                            number = hexNumber
                        }
                    } else {
                        // Attempt to parse as decimal
                        if let decNumber = UInt16(input, radix: 10) {
                            number = decNumber
                            update()
                        }
                    }
#else
                    // Attempt to parse as hexadecimal
                    if let hexNumber = UInt16(input, radix: 16) {
                        number = hexNumber
                        update()
                    }
#endif
                }
            ))
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .frame(width: 64)
        }
    }
}

struct LabeledDecTextField: View {
    var label = "??"
    @Binding var number: UInt16

    var body: some View {
        HStack {
            Text(label)
                .frame(width: 22)
                .multilineTextAlignment(.trailing)
            DecTextField(number: $number)
        }
    }
}

struct DecTextField: View {
    @Binding var number: UInt16

    var body: some View {
        HStack {
            TextField("", text: Binding<String>(
                get: {
                    // Display the number as a decimal string
                    String(format: "%d", number)
                },
                set: { newValue in
                    let input = newValue.uppercased().trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    // Attempt to parse as decimal
                    if let decNumber = UInt16(input, radix: 10) {
                        number = decNumber
                    }
                }
            ))
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .frame(width: 64)
        }
    }
}

struct HexBoundTextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            @State var n8 : UInt8 = 23
            @State var n16 : UInt16 = 65535
            LabeledHex8TextField(label: "A:", number: $n8)
                .frame(maxWidth: .infinity, alignment: .leading)
            LabeledHex8TextField(label: "DP:", number: $n8)
                .frame(maxWidth: .infinity, alignment: .leading)
            LabeledHex16TextField(label: "X:", number: $n16)
                .frame(maxWidth: .infinity, alignment: .leading)
            Hex16TextField(number: $n16)
                .frame(maxWidth: .infinity, alignment: .leading)
            LabeledDecTextField(label: "X:", number: $n16)
                .frame(maxWidth: .infinity, alignment: .leading)
            DecTextField(number: $n16)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
