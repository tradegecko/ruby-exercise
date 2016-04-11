class Emoji
  def self.random
    list = %w{😃 😁 😂 😘 ☺ 😎 🙄 😚 😊 😉 😳 🤖 👽 😹 👈 👌 👍 🍕 ❤ 🍭 🍪 🍻 🚀 🌈 🎉 🍻 💕}
    list[rand(list.length)]
  end
end