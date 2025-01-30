import SwiftUI

struct Hex8TextField: View {
    var label = "??"
    @Binding var number: UInt8

    var body: some View {
        HStack {
            Text(label)
                .frame(width: 28)
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
                    }
                    #endif
                }
            ))
            .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

struct Hex16TextField: View {
    var label = "??"
    @Binding var number: UInt16

    var body: some View {
        HStack {
            Text(label)
                .frame(width: 28)
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
                        }
                    }
#else
// Attempt to parse as hexadecimal
if let hexNumber = UInt16(input, radix: 16) {
    number = hexNumber
}
#endif
                }
            ))
            .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

struct HexBoundTextField_Previews: PreviewProvider {
    static var previews: some View {
        @State var n : UInt16 = 3
        Hex16TextField(number: $n)
    }
}
