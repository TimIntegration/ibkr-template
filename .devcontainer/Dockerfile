FROM mcr.microsoft.com/devcontainers/anaconda:latest
# https://mcr.microsoft.com/en-us/artifact/mar/devcontainers/anaconda/tags

# Uses "Spaceship" theme with some customization. Uses some bundled plugins and installs some more from github
RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.2.1/zsh-in-docker.sh)" -- \
    -p git \
    -p ssh-agent \
    -p https://github.com/zsh-users/zsh-autosuggestions \
    -p https://github.com/zsh-users/zsh-completions

# Set the default shell to zsh
RUN chsh -s $(which zsh)

RUN yes | conda install -c conda-forge \
    ta-lib \
    uv

# # Download TWS API
RUN mkdir -p /scripts
COPY ./.devcontainer/download_twsapi.sh /scripts
RUN chmod -R 777 /scripts/
RUN chmod +x /scripts/download_twsapi.sh
RUN /scripts/download_twsapi.sh

COPY requirements.txt .
RUN uv pip install -r requirements.txt --system

#add zsh config
ENV SETUSER=vscode
COPY ./.devcontainer/.zshrc /home/$SETUSER/.zshrc
COPY ./.devcontainer/.p10k.zsh /home/$SETUSER/.p10k.zsh
RUN chown -R $SETUSER:$SETUSER /home/$SETUSER/.zshrc /home/$SETUSER/.p10k.zsh

ENV ZSH_CUSTOM=/home/$SETUSER/.oh-my-zsh/custom/
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-completions.git \
    ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
RUN git clone --depth 1 https://github.com/junegunn/fzf.git /home/$SETUSER/.fzf
RUN /home/$SETUSER/.fzf/install --all

SHELL ["/usr/bin/zsh", "-c"]
RUN source /opt/conda/etc/profile.d/conda.sh && conda init zsh

# Make RUN commands use the new environment:
# SHELL ["conda", "run", "-n", "myenv", "/usr/bin/zsh", "-c"]

CMD ["zsh"]
